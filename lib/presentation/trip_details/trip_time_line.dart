import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:novoy/model/place_model.dart';
import 'package:novoy/model/visited_places_model.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../blocs/trip/trip_bloc.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '/model/trip_model.dart';

class TripTimeLine extends StatefulWidget {
  final String tripId;
  final TripDestination tripDestination;
  const TripTimeLine({
    super.key,
    required this.tripDestination,
    required this.tripId,
  });

  @override
  State<TripTimeLine> createState() => _TripTimeLineState();
}

class _TripTimeLineState extends State<TripTimeLine> {
  late TripDestination tripDestination = widget.tripDestination;
  late String tripId = widget.tripId;
  late List<DateTime> dateRange;

  List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  @override
  void initState() {
    super.initState();
    dateRange = getDatesBetween(
      DateTime.fromMillisecondsSinceEpoch(
        tripDestination.startDate!.millisecondsSinceEpoch,
      ),
      DateTime.fromMillisecondsSinceEpoch(
        // 1000
        tripDestination.leaveDate!.millisecondsSinceEpoch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        // if (state is TripLoaded) {
        //   tripDestination = state.trips
        //       .firstWhere((element) => element.tripId == tripId)
        //       .destinations!
        //       .firstWhere(
        //         (element) =>
        //             element.destinationId == tripDestination.destinationId,
        //       );
        // }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dateRange.length,
          itemBuilder: (context, index) {
            String formattedDate =
                DateFormat('yyyy-MM-dd').format(dateRange[index]);
            List<VisitedPlaces> visitedPlaces =
                tripDestination.visitedPlaces ?? [];

            var places = visitedPlaces
                .where(
                  (element) =>
                      element.visitDate!.toDate().day == dateRange[index].day,
                )
                .map((e) => e.place)
                .toList();
            for (var i = 0; i < visitedPlaces.length; i++) {
              verticalLine.add(
                const SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return Row(
              children: [
                const SizedBox(
                  height: 70,
                  child: VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () => onSearchAndAddVisitedPlaces(
                              context,
                              dateRange[index],
                            ),
                            icon: const Icon(
                              Icons.add_location_alt_outlined,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      responsive.sizedBoxW10,
                      if (places.isNotEmpty)
                        ListView.builder(
                          // onReorder: (int oldIndex, int newIndex) {
                          //   setState(() {
                          //     if (newIndex > oldIndex) {
                          //       newIndex -= 1;
                          //     }
                          //     final item = places.removeAt(oldIndex);
                          //     places.insert(newIndex, item);
                          //   });
                          // },
                          shrinkWrap: true,
                          itemCount: places.length,
                          itemBuilder: (context, index) {
                            PlaceModel place = places[index]!;
                            //? on drag left delete place write this code

                            return Dismissible(
                              key: Key(places[index]!.pId!),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                context.read<TripBloc>().add(
                                      RemoveVisitedPlaceFromTripDestination(
                                        placeId: place.pId!,
                                        tripDestination: tripDestination,
                                      ),
                                    );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: place.imageUrls != null &&
                                            place.imageUrls!.isNotEmpty
                                        ? NetworkImage(
                                            place.imageUrls![0],
                                          )
                                        : null, // place.imageUrls![0]
                                  ),
                                  title: kText(text: place.name ?? ""),
                                  subtitle:
                                      kText(text: place.description ?? ""),
                                ),
                              ),
                            );
                          },
                        ),
                      responsive.sizedBoxH15,
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> verticalLine = [
    const SizedBox(
      height: 50,
      child: VerticalDivider(
        thickness: 2,
        color: Colors.grey,
      ),
    ),
  ];

  void onSearchAndAddVisitedPlaces(BuildContext context, DateTime date) async {
    var place = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppStrings.googleApiKey,
      mode: Mode.overlay,
      types: [],
      strictbounds: false,
      components: [Component(Component.country, 'sa')],
      onError: (err) {
        print(err);
      },
    );

    if (place != null) {
      final plist = GoogleMapsPlaces(
        apiKey: AppStrings.googleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      String placeid = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeid);

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
      PlaceModel placeModel = PlaceModel(
        pId: placeid,
        name: detail.result.name,
        description: detail.result.formattedAddress,
        address: detail.result.formattedAddress,
        lat: lat.toString(),
        lng: lang.toString(),
        image: "",
        imageUrls: photos,
      );
      VisitedPlaces visitedPlace = VisitedPlaces(
        place: placeModel,
        visitDate: Timestamp.fromDate(date),
      );
      context.read<TripBloc>().add(
            AddVisitedPlaceToTripDestination(
              visitedPlace: visitedPlace,
              tripDestination: tripDestination,
            ),
          );
      setState(() {});
    }
  }
}
