import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:novoy/blocs/trip/trip_bloc.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/trip_model.dart';
import 'package:novoy/resources/assets_maneger.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/resources/strings_maneger.dart';
import 'package:novoy/shared/component/text_form_field.dart';

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

  TripDestination? destinations;

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
      backgroundColor: ColorManager.lightPrimary,
      appBar: AppBar(
        title: const Text("Create a Plan"),
      ),
      body: BlocConsumer<TripBloc, TripState>(
        listener: (context, state) {
          if (state is TripSuccess) {
            tripNameController.clear();
            startDateController.clear();
            endDateController.clear();
            destinations = null;
            startLocationDescription = "Destination Location";
            endLocationDescription = "Place Location";

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is TripFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              return Form(
                key: formState,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                    apiKey: AppStrings.googleApiKey,
                                    mode: Mode.fullscreen,
                                    types: [],
                                    strictbounds: false,
                                    components: [
                                      Component(Component.country, 'sa'),
                                    ],
                                    onError: (err) {
                                      print(err);
                                    },
                                  );

                                  if (place != null) {
                                    log(place.toString());
                                    setState(() {
                                      startLocationDescription =
                                          place.description.toString();
                                    });

                                    final plist = GoogleMapsPlaces(
                                      apiKey: AppStrings.googleApiKey,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    String placeid = place.placeId ?? "0";
                                    final detail = await plist
                                        .getDetailsByPlaceId(placeid);
                                    for (var item in detail.result.photos) {
                                      log(item.photoReference);
                                    }
                                    List<String> photos = [];
                                    for (var item in detail.result.photos) {
                                      String photoReference =
                                          item.photoReference;
                                      String photoUrl =
                                          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${AppStrings.googleApiKey}';
                                      photos.add(photoUrl);
                                    }

                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    destinations = TripDestination(
                                      destinationId: "",
                                      tripId: "",
                                      createdUid: kUser!.uId,
                                      name: place.description,
                                      comment: "",
                                      startDate: null,
                                      leaveDate: null,
                                      description:
                                          detail.result.formattedAddress,
                                      image: photos,
                                      location: GeoPoint(lat, lang),
                                      visitedPlaces: [],
                                    );

                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorManager.primary,
                                      ),
                                      // border: BorderSide(color: ColorManager.primary),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ListTile(
                                      leading:
                                          const Icon(CupertinoIcons.location),
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
                                log("create trip");
                                if (!formState.currentState!.validate() ||
                                    destinations == null) {
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
                                destinations!.leaveDate =
                                    Timestamp.fromDate(endTrip!);

                                destinations!.startDate =
                                    Timestamp.fromDate(startTrip!);

                                TripModelN trip = TripModelN(
                                  tripId: "",
                                  uId: kUser?.uId,
                                  name: tripNameController.text,
                                  destinationsIds: [],
                                  createOn: Timestamp.now(),
                                  users: [],
                                  destinations: [destinations!],
                                );

                                context
                                    .read<TripBloc>()
                                    .add(AddTrip(trip: trip));
                              },
                              child: state is TripAddLoading
                                  ? CircularProgressIndicator(
                                      color: ColorManager.scaffold,
                                    )
                                  : const Text("Create"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
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
