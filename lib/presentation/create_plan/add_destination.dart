import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:novoy/blocs/trip/trip_bloc.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/trip_model.dart';
import 'package:novoy/resources/assets_maneger.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/resources/strings_maneger.dart';
import 'package:novoy/shared/component/text_form_field.dart';

import '../../resources/color_maneger.dart';

class AddDestinationScreen extends StatefulWidget {
  final TripModelN trip;
  final TripDestination? oldDestination;
  const AddDestinationScreen({
    super.key,
    required this.trip,
    this.oldDestination,
  });

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  late TripModelN trip = widget.trip;
  late TripDestination? oldDestination = widget.oldDestination;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final timeFormat = DateFormat('h:mm a');

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final destinationController = TextEditingController();

  DateTime? startTrip;
  DateTime? endTrip;

  TripDestination? destination;

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
      startTrip = oldDestination!.startDate!.toDate();
      endTrip = oldDestination!.leaveDate!.toDate();
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
    return BlocConsumer<TripBloc, TripState>(
      listener: (context, state) {
        if (state is TripSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.pop(context, oldDestination != null ? true : false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.lightPrimary,
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
                                final detail =
                                    await plist.getDetailsByPlaceId(placeid);

                                List<String> photos = [];
                                for (var item in detail.result.photos) {
                                  String photoReference = item.photoReference;
                                  String photoUrl =
                                      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${AppStrings.googleApiKey}';
                                  photos.add(photoUrl);
                                }

                                final geometry = detail.result.geometry!;
                                final lat = geometry.location.lat;
                                final lang = geometry.location.lng;
                                destination = TripDestination(
                                  destinationId: "",
                                  tripId: trip.tripId,
                                  createdUid: kUser!.uId,
                                  name: place.description,
                                  comment: "",
                                  startDate: null,
                                  leaveDate: null,
                                  description: detail.result.formattedAddress,
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
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorManager.primary),
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
                                  destination!.leaveDate =
                                      Timestamp.fromDate(endTrip!);

                                  destination!.startDate =
                                      Timestamp.fromDate(startTrip!);

                                  trip.destinations!.add(destination!);

                                  context.read<TripBloc>().add(
                                        AddDestinationToTheTrip(
                                          updatedTrip: trip,
                                        ),
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
                                  destination!.leaveDate =
                                      Timestamp.fromDate(endTrip!);

                                  destination!.startDate =
                                      Timestamp.fromDate(startTrip!);
                                  destination?.destinationId =
                                      oldDestination!.destinationId;

                                  log("destinations ${destination!.toJson()}");
                                  log("destinationId ${destination?.destinationId}");
                                  // replace new destination with old one in the list in the same index
                                  log("oldDestination ${oldDestination!.toJson()}");
                                  // log(" index ${}");
                                  trip.destinations![trip.destinations!.indexOf(
                                    oldDestination!,
                                  )] = destination!;
                                  context.read<TripBloc>().add(
                                        UpdateDestination(
                                          trip: trip,
                                          updatedDestination: destination!,
                                        ),
                                      );
                                },
                          child: state is TripAddLoading
                              ? CircularProgressIndicator(
                                  color: ColorManager.scaffold,
                                )
                              : Text(
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
      },
    );
  }
}
