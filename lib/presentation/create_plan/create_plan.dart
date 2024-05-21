import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '/global/global.dart';
import '/model/trip/trip_model.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/resources/assets_maneger.dart';
import '/resources/color_maneger.dart';
import '/resources/constant_maneger.dart';
import '/resources/responsive.dart';
import '/shared/component/text_form_field.dart';
import '/shared/utils/utils.dart';

import '../../model/trip_member/trip_member_model.dart';
import '../../shared/component/k_text.dart';

class CreatePlan extends StatefulWidget {
  const CreatePlan({super.key});

  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final tripNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final destinationController = TextEditingController();
  DateTime? startTrip;
  DateTime? endTrip;

  TripDestinationModel? destination;

  // GoogleMapController? mapController; //contrller for Google map

  String startLocationDescription = "Destination Location";
  String endLocationDescription = "Place Location";

  TimeOfDay selectedTime = TimeOfDay.now();
  final timeFormat = DateFormat('h:mm a');

  Future<void> startDate(BuildContext context) async {
    startTrip = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (startTrip != null) {
      setState(() {
        // selectedDate = picked;
        startDateController.text =
            '${intl.DateFormat('yyyy-MM-dd').format(startTrip!)}  ';
      });
    }
  }

  Future<void> endDate(BuildContext context) async {
    endTrip = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (endTrip != null) {
      setState(() {
        // selectedDate = picked;
        endDateController.text =
            '${intl.DateFormat('yyyy-MM-dd').format(endTrip!)}  ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        title: const Text("Create a Plan"),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      responsive.sizedBoxH10,
                      const Text("Trip Name"),
                      AppTextFormField(
                        hint: "Enter Trip Name",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "trip name cant be empty";
                          }
                          return null;
                        },
                        controller: tripNameController,
                        prefix: Image.asset(AppAssets.plane),
                      ),
                      SizedBox(
                        height: responsive.sHeight(context) * .1,
                      ),
                      const Text("Destination"),
                      InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: AppConstant.apiKey,
                            mode: Mode.fullscreen,
                            types: [
                              '(cities)',
                            ],
                            strictbounds: false,
                            components: [
                              Component(Component.country, 'sa'),
                            ],
                            onError: (err) {
                              log("error $err");
                            },
                          );

                          if (place != null) {
                            log(place.toString());
                            setState(() {
                              startLocationDescription =
                                  place.description.toString();
                            });

                            final plist = GoogleMapsPlaces(
                              apiKey: AppConstant.apiKey,
                              apiHeaders:
                                  await const GoogleApiHeaders().getHeaders(),
                            );
                            String placeid = place.placeId ?? "0";
                            final detail =
                                await plist.getDetailsByPlaceId(placeid);
                            for (var item in detail.result.photos) {
                              log(item.photoReference);
                            }
                            List<String> photos = [];
                            for (var item in detail.result.photos) {
                              String photoReference = item.photoReference;
                              String photoUrl =
                                  'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${AppConstant.apiKey}';
                              photos.add(photoUrl);
                            }

                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            final docId = FirebaseFirestore.instance
                                .collection(
                                  AppConstant.destinationsCollection,
                                )
                                .doc()
                                .id;
                            TripMemberModel createdBy = TripMemberModel(
                              name: kUser!.name,
                              email: kUser!.email,
                              phone: kUser!.phone,
                              uId: kUser!.uId,
                              gender: kUser!.gender,
                              age: kUser!.age,
                            );
                            destination = TripDestinationModel(
                              destinationId: docId,
                              tripId: "",
                              createdBy: createdBy,
                              name: place.description,
                              startDate: null,
                              leaveDate: null,
                              description: detail.result.formattedAddress,
                              image: photos,
                              location: GeoPoint(lat, lang),
                              visitedPlaces: [],
                              createdAt: DateTime.now(),
                            );

                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                              ),
                              // border: BorderSide(color: ColorManager.primary),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: const Icon(CupertinoIcons.location),
                              horizontalTitleGap: 0,
                              title: Text(
                                startLocationDescription,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: const Icon(Icons.search),
                              dense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.sHeight(context) * .1,
                      ),
                      const Text("Start Date"),
                      AppTextFormField(
                        readonly: true,
                        hint: "Select Start Date",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "date cant be empty";
                          }
                          return null;
                        },
                        onTap: () async => await startDate(context),
                        controller: startDateController,
                        prefix: Image.asset(AppAssets.calender),
                      ),
                      SizedBox(
                        height: responsive.sHeight(context) * .1,
                      ),
                      const Text("End Date"),
                      AppTextFormField(
                        readonly: true,
                        hint: "Select End Date",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "date cant be empty";
                          }
                          return null;
                        },
                        onTap: () async => await endDate(context),
                        controller: endDateController,
                        prefix: Image.asset(AppAssets.calender),
                      ),
                      SizedBox(
                        height: responsive.sHeight(context) * .02,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        context.loaderOverlay.show();
                        log("create trip");
                        if (!formState.currentState!.validate() ||
                            destination == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("fill all fields"),
                            ),
                          );
                          return;
                        } else if (endTrip!.isBefore(startTrip!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "end date cant be before start date",
                              ),
                            ),
                          );
                          return;
                        }
                        final tripId = FirebaseFirestore.instance
                            .collection(AppConstant.tripsCollection)
                            .doc()
                            .id;

                        destination = destination!.copyWith(
                          tripId: tripId,
                          startDate: startTrip,
                          leaveDate: endTrip,
                        );

                        TripMemberModel createdBy = TripMemberModel(
                          name: kUser!.name,
                          email: kUser!.email,
                          phone: kUser!.phone,
                          uId: kUser!.uId,
                          gender: kUser!.gender,
                          age: kUser!.age,
                        );

                        TripModel trip = TripModel(
                          tripId: tripId,
                          createdBy: createdBy,
                          name: tripNameController.text,
                          destinationsIds: [
                            destination!.destinationId!,
                          ],
                          createOn: DateTime.now(),
                          groupMembers: [],
                          destinations: [
                            destination!,
                          ],
                        );

                        log("kUser ${kUser}");
                        log("trip ${trip}");

                        final isAdd = await Utils.addNewTrip(
                          trip: trip,
                        );
                        context.loaderOverlay.hide();

                        if (isAdd) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Trip Created"),
                            ),
                          );

                          tripNameController.clear();
                          startDateController.clear();
                          endDateController.clear();
                          destination = null;
                          startLocationDescription = "Destination Location";
                          endLocationDescription = "Place Location";

                          Navigator.of(context).pop(true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to create trip"),
                            ),
                          );
                        }
                      },
                      child: kText(text: "Create"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // BlocConsumer<TripBloc, TripState>(
      //   listener: (context, state) {
      //     if (state is TripAddLoading) {
      //       context.loaderOverlay.show();
      //     }
      //     if (state is TripSuccess) {
      //       context.loaderOverlay.hide();
      //       tripNameController.clear();
      //       startDateController.clear();
      //       endDateController.clear();
      //       destination = null;
      //       startLocationDescription = "Destination Location";
      //       endLocationDescription = "Place Location";

      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(state.message),
      //         ),
      //       );
      //       Navigator.of(context).pop();
      //     } else if (state is TripFailure) {
      //       context.loaderOverlay.hide();
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(state.message),
      //         ),
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     return BlocBuilder<TripBloc, TripState>(
      //       builder: (context, state) {
      //         return
      //       },
      //     );
      //   },
    );
  }

  Widget addNewDestination() {
    return const Column(
      children: [],
    );
  }

  // DateTimeRange dateRange = DateTimeRange(
  //   start: DateTime.now(),
  //   end: DateTime.now(),
  // );

  // Future<DateTimeRange?> pickDate() async => await showDateRangePicker(
  //       context: context,
  //       initialDateRange: dateRange,
  //       firstDate: DateTime(2023),
  //       lastDate: DateTime(2100),
  //       builder: (context, child) {
  //         return Theme(
  //           data: ThemeData(
  //             dialogBackgroundColor: ColorManager.lightPrimary,
  //           ),
  //           child: child!,
  //         );
  //       },
  //     );

  // Future startDate() async {
  //   var cubit = HomeCubit.get(context);
  //   DateTimeRange? date = await pickDate();
  //   if (date == null) return;
  //   /* TimeOfDay? time = await pickTime();*/
  //   final firstDate = date.start;

  //   setState(() {
  //     HomeCubit.get(context).startdateController.text =
  //         '${intl.DateFormat('yyyy-MM-dd').format(firstDate)}  ';
  //   });
  // }

  // Future endDate() async {
  //   var cubit = HomeCubit.get(context);
  //   DateTimeRange? date = await pickDate();
  //   if (date == null) return;
  //   /* TimeOfDay? time = await pickTime();*/

  //   final lastDate = date.end;
  //   setState(() {
  //     HomeCubit.get(context).enddateController.text =
  //         ' ${intl.DateFormat('yyyy-MM-dd').format(lastDate)}';
  //   });
  // }
}
