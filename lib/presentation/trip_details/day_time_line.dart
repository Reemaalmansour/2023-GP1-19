// collection
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../global/global.dart';
import '../../model/review_result/review_result.dart';
import '../../model/trip_member/trip_member_model.dart';
import '../../resources/constant_maneger.dart';
import '../../resources/responsive.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/model/trip_place/trip_place_model.dart';
import '/shared/utils/utils.dart';
import 'visted_place_card.dart';

class DayTimeLine extends StatefulWidget {
  final DateTime date;
  final TripDestinationModel tripDestination;
  final List<TripPlaceModel> visitedPlaces;
  final TripPlaceModel? addPlace;

  const DayTimeLine({
    super.key,
    required this.date,
    required this.tripDestination,
    required this.visitedPlaces,
    this.addPlace,
  });

  @override
  State<DayTimeLine> createState() => _DayTimeLineState();
}

class _DayTimeLineState extends State<DayTimeLine> {
  late DateTime date;
  late List<TripPlaceModel> visitedPlaces;
  late String formattedDate;
  late TripDestinationModel tripDestination;
  late bool? isAdd;
  late TripPlaceModel? addPlace;

  @override
  void initState() {
    date = widget.date;
    tripDestination = widget.tripDestination;
    visitedPlaces = widget.visitedPlaces;

    formattedDate = DateFormat('yyyy-MM-dd').format(date);

    addPlace = widget.addPlace;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    });
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
                      date,
                    ),
                    icon: const Icon(
                      Icons.add_location_alt_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
              responsive.sizedBoxW10,
              if (visitedPlaces.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: visitedPlaces.length,
                  itemBuilder: (context, index) {
                    TripPlaceModel place = visitedPlaces[index];

                    return Dismissible(
                      key: ValueKey(
                        place.pId! + index.toString() + date.toString(),
                      ),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        final response =
                            await _showConfirmationDialog(context, place);

                        return response;
                      },
                      onDismissed: (direction) {
                        // Remove the item from the data source
                        setState(() {
                          visitedPlaces.removeAt(index);
                        });
                      },
                      child: VisitedPlaceCard(
                        key: ValueKey(
                          place.pId! + index.toString() + date.toString(),
                        ),
                        tripDestination: tripDestination,
                        place: place,
                        isAdd: addPlace?.pId == place.pId ? true : false,
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
  }

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    TripPlaceModel place,
  ) async {
    bool isDeleted = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: Text(
          'Do you want to remove the ${place.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isDeleted = false;
              });
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              context.loaderOverlay.show();
              await Utils.onRemoveVisitedPlaceFromTripDestination(
                destination: tripDestination,
                place: place,
              );
              Navigator.of(context).pop();
              setState(() {
                isDeleted = true;
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return isDeleted;
  }

  void onSearchAndAddVisitedPlaces(BuildContext context, DateTime date) async {
    var place = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConstant.apiKey,
      mode: Mode.overlay,
      types: [],
      strictbounds: false,
      components: [Component(Component.country, 'sa')],
      onError: (err) {
        print(err);
      },
    );

    if (place != null) {
      context.loaderOverlay.show();
      final plist = GoogleMapsPlaces(
        apiKey: AppConstant.apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      String placeId = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeId);

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
      log('lat: $lat, lang: $lang');
      TripMemberModel createdBy = TripMemberModel(
        name: kUser!.name,
        email: kUser!.email,
        phone: kUser!.phone,
        uId: kUser!.uId,
        gender: kUser!.gender,
        age: kUser!.age,
      );

      TripPlaceModel placeModel = TripPlaceModel(
        pId: placeId,
        name: detail.result.name,
        description: detail.result.formattedAddress,
        address: detail.result.formattedAddress,
        lat: lat.toString(),
        lng: lang.toString(),
        imageUrls: photos,
        rating: detail.result.rating,
        priceLevel: detail.result.priceLevel != null
            ? Utils.decodePriceLevelFromEnum(detail.result.priceLevel!)
                .toString()
            : "0",
        isFav: false,
        createdBy: createdBy,
        types: detail.result.types,
        createdAt: DateTime.now(),
        visitDate: date,
        comments: [],
        reviews: [],
      );

      final placeDetails = await Utils.fetchPlaceDetails(placeId);

      final reviews = ReviewResult.fromJson(placeDetails['result']);
      List<String> reviewList = [];
      if (reviews.reviews != null && reviews.reviews!.isNotEmpty) {}
      for (var item in reviews.reviews!) {
        reviewList.add(item.text ?? "");
      }

      placeModel = placeModel.copyWith(
        reviews: reviewList,
      );

      // context.read<TripBloc>().add(
      //       AddVisitedPlaceToTripDestination(
      //         visitedPlace: visitedPlace,
      //         tripDestination: tripDestination,
      //       ),
      //     );
      await Utils.onAddVisitedPlaceToTripDestination(
        destination: tripDestination,
        visitedPlace: placeModel,
      );
      context.loaderOverlay.hide();

      setState(() {
        visitedPlaces.add(placeModel);
      });
    }
  }
}
