import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import '/global/global.dart';
import '/model/trip/trip_model.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/model/trip_member/trip_member_model.dart';
import '/resources/assets_maneger.dart';
import '/resources/responsive.dart';
import '/shared/component/text_form_field.dart';

import '../../resources/color_maneger.dart';
import '../../resources/constant_maneger.dart';
import '../../shared/utils/utils.dart';

class AddDestinationScreen extends StatefulWidget {
  final TripModel trip;
  final TripDestinationModel? oldDestination;
  const AddDestinationScreen({
    super.key,
    required this.trip,
    this.oldDestination,
  });

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  late TripModel trip = widget.trip;
  late TripDestinationModel? oldDestination = widget.oldDestination;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final timeFormat = DateFormat('h:mm a');

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

  Future<void> startDate(BuildContext context) async {
    //? increase the leave date by one day

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
            '${DateFormat('yyyy-MM-dd').format(startTrip!)}  ';
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
            '${DateFormat('yyyy-MM-dd').format(endTrip!)}  ';
      });
    }
  }

  @override
  void initState() {
    log("oldDestination ${oldDestination?.destinationId}");
    if (oldDestination != null) {
      destination = oldDestination;
      startLocationDescription = oldDestination!.name!;
      startTrip = oldDestination!.startDate!;
      endTrip = oldDestination!.leaveDate!;
      startDateController.text =
          '${DateFormat('yyyy-MM-dd').format(startTrip!)}  ';
      endDateController.text = '${DateFormat('yyyy-MM-dd').format(endTrip!)}  ';
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
    destinationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: AppBar(
        title: Text(
          oldDestination == null ? "Add Destination" : "Update Destination",
        ),
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
                      const Text("New Destination"),
                      InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: AppConstant.apiKey,
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
                                .collection("destinations")
                                .doc()
                                .id;

                            destination = TripDestinationModel(
                              destinationId:
                                  oldDestination?.destinationId ?? docId,
                              tripId: trip.tripId,
                              createdBy: null,
                              name: place.description,
                              startDate: oldDestination?.startDate,
                              leaveDate: oldDestination?.leaveDate,
                              description: detail.result.formattedAddress,
                              image: photos,
                              location: GeoPoint(lat, lang),
                              visitedPlaces:
                                  oldDestination?.visitedPlaces ?? [],
                              createdAt:
                                  oldDestination?.createdAt ?? DateTime.now(),
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
                              border: Border.all(color: AppColors.primary),
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
                      onPressed: oldDestination == null
                          ? () async {
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
                              TripMemberModel createdBy = TripMemberModel(
                                name: kUser!.name,
                                email: kUser!.email,
                                phone: kUser!.phone,
                                uId: kUser!.uId,
                                gender: kUser!.gender,
                                age: kUser!.age,
                              );
                              TripDestinationModel updatedDestination =
                                  destination!.copyWith(
                                startDate: startTrip,
                                leaveDate: endTrip,
                                createdBy: createdBy,
                              );
                              TripModel uTrip = trip.copyWith(
                                destinationsIds: [
                                  ...trip.destinationsIds!,
                                  updatedDestination.destinationId!,
                                ],
                                destinations: [
                                  ...trip.destinations!,
                                  updatedDestination,
                                ],
                              );

                              // context.read<TripBloc>().add(
                              //       AddDestinationToTheTrip(
                              //         updatedTrip: uTrip,
                              //       ),
                              //     );

                              // update
                              await Utils.onAddDestinationToTheTrip(
                                trip: uTrip,
                                destination: updatedDestination,
                              );
                              Navigator.pop(
                                context,
                                oldDestination != null ? true : false,
                              );
                            }
                          : () async {
                              if (!formState.currentState!.validate() ||
                                  destination == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("fill all fields"),
                                  ),
                                );
                                return;
                              }
                              TripDestinationModel uDestination =
                                  destination!.copyWith(
                                startDate: startTrip,
                                leaveDate: endTrip,
                              );

                              log("destinations ${uDestination.toString()}");
                              log("destinationId ${uDestination.destinationId}");
                              // replace new destination with old one in the list in the same index
                              log("oldDestination ${oldDestination!.toJson()}");
                              // log(" index ${}");
                              trip.destinations![trip.destinations!.indexOf(
                                oldDestination!,
                              )] = uDestination;
                              // context.read<TripBloc>().add(
                              //       UpdateDestination(
                              //         trip: trip,
                              //         updatedDestination: uDestination,
                              //       ),
                              //     );
                              await Utils.onUpdateDestinationToTheTrip(
                                trip: trip,
                                destination: uDestination,
                              );
                              Navigator.pop(
                                context,
                                oldDestination != null ? true : false,
                              );
                            },
                      child: Text(
                        oldDestination == null
                            ? "Add Destination"
                            : "Update Destination",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
