// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../global/global.dart';
import '../../../model/review_result/review_result.dart';
import '../../../model/trip_member/trip_member_model.dart';
import '../../../model/trip_place/trip_place_model.dart';
import '../../../shared/utils/utils.dart';
import '../../trip_details/trip_details.dart';
import '/model/place/place_model.dart';
import '/model/trip/trip_model.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/shared/component/k_text.dart';

class SelectData extends StatefulWidget {
  final PlaceModel place;
  final TripModel trip;
  final TripDestinationModel tripDestination;
  const SelectData({
    super.key,
    required this.trip,
    required this.tripDestination,
    required this.place,
  });

  @override
  State<SelectData> createState() => _SelectDataState();
}

class _SelectDataState extends State<SelectData> {
  late TripModel trip;
  late TripDestinationModel tripDestination;
  late PlaceModel place;
  List<String> dates = [];

  List<String> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<String> dates = [];
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dates.add(currentDate.toString());
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  @override
  void initState() {
    trip = widget.trip;
    tripDestination = widget.tripDestination;
    place = widget.place;
    dates = getDatesBetween(
      DateTime.fromMillisecondsSinceEpoch(
        tripDestination.startDate!.millisecondsSinceEpoch,
      ),
      DateTime.fromMillisecondsSinceEpoch(
        tripDestination.leaveDate!.millisecondsSinceEpoch,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Date'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  String date = dates[index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      // date as Jan 12, 2021
                      title: kText(
                        text: DateFormat.yMMMd().format(DateTime.parse(date)),
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          TripMemberModel createdBy = TripMemberModel(
                            name: kUser!.name,
                            email: kUser!.email,
                            phone: kUser!.phone,
                            uId: kUser!.uId,
                            gender: kUser!.gender,
                            age: kUser!.age,
                          );
                          TripPlaceModel placeModel = TripPlaceModel(
                            pId: place.pId,
                            name: place.name,
                            description: place.description,
                            address: place.address,
                            lat: place.lat,
                            lng: place.lng,
                            imageUrls: place.imageUrls,
                            priceLevel: place.priceLevel != null
                                ? Utils.encodePriceLevel(place.priceLevel!)
                                : null,
                            rating: place.rating,
                            isFav: false,
                            createdBy: createdBy,
                            types: place.types ?? [],
                            createdAt: DateTime.now(),
                            visitDate: DateTime.parse(date),
                            comments: [],
                            reviews: [],
                          );
                          // get place details
                          final placeDetails =
                              await Utils.fetchPlaceDetails(place.pId!);

                          final reviews =
                              ReviewResult.fromJson(placeDetails['result']);
                          List<String> reviewList = [];
                          if (reviews != null &&
                              reviews.reviews != null &&
                              reviews.reviews!.isNotEmpty) {}
                          for (var item in reviews.reviews!) {
                            reviewList.add(item.text ?? "");
                          }

                          placeModel = placeModel.copyWith(
                            reviews: reviewList,
                          );

                          await Utils.onAddVisitedPlaceToTripDestination(
                            destination: tripDestination,
                            visitedPlace: placeModel,
                          );
                          context.loaderOverlay.hide();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TripDetails(
                                tripModel: trip,
                                isShared: false,
                                addPlace: placeModel,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add_location_alt_outlined,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
