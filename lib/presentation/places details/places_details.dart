import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/places/places_bloc.dart';
import '../../global/global.dart';
import '../../model/place/place_model.dart';
import '../../resources/constant_maneger.dart';
import '../../shared/network/cache_helper.dart';
import '../add_place_to_trip/add_place_to_trip.dart';
import '../add_place_to_trip/select_date/select_date.dart';
import '../add_place_to_trip/select_destination/select_destination.dart';
import '/model/review_result/review_result.dart';
import '/resources/color_maneger.dart';
import '/resources/responsive.dart';
import '/shared/component/k_text.dart';
import '/shared/utils/utils.dart';

class PlacesDetails extends StatefulWidget {
  final PlaceModel place;
  final bool isAdd;

  const PlacesDetails({
    Key? key,
    required this.place,
    required this.isAdd,
  }) : super(key: key);

  @override
  State<PlacesDetails> createState() => _PlacesDetailsState();
}

class _PlacesDetailsState extends State<PlacesDetails> {
  late bool isAdd = widget.isAdd;
  PlaceModel? place;
  bool isFav = false;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    place = widget.place;
    isFav = place?.isFav ?? false;
    // randomize reviews in the list

    if (place?.reviewsResult == null) {
      fetchPlaceDetails();
    }

    // listen to scroll controller
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // remove some types of places from the list of interests
        // place?.types.removeWhere((element) => element == "point_of_interest");
        // place?.types.removeWhere((element) => element == "establishment");
        // place?.types.removeWhere((element) => element == "");

        Set<String> set1 = Set<String>.from(kUser!.listOfInterestsTypes ?? []);
        Set<String> set2 = Set<String>.from(place?.types ?? []);
        // load more reviews
        if (set1.length > 5) {
          // delete the first elements 3 elements
          set1.remove(set1.first);
          set1.remove(set1.first);
          set1.remove(set1.first);
        }
        if (kUser != null && !set2.every((element) => set1.contains(element)))
          await Future.delayed(const Duration(seconds: 2), () async {
            log("set1: $set1");
            setState(() {
              // add types of places to Global
              // check if the place is already added to the list of interests

              Set<String> mergedSet = {...set1, ...set2};
              kUser = kUser!.copyWith(
                listOfInterestsTypes: mergedSet.toList(),
              );
              // set in firebase the updated user
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(kUser!.uId)
                  .set(
                    kUser!.toJson(),
                  );
            });
          });
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      // add the place to the list of recent places
      // check if the place is already in the list of recent places by comparing the id
      if (!Global.recentPlaces.any((element) => element.pId == place!.pId) &&
          !Global.discoveryPlaces.any((element) => element.pId == place!.pId)) {
        Global.recentPlaces.add(place!);
      }
      // if the list of recent places is bigger than 5 remove the first elements to keep the list of recent places with 5 elements
      if (Global.recentPlaces.length > 5) {
        Global.recentPlaces.removeAt(0);
      }

      // save the recent places in the cache
      CacheHelper.saveDataToHive(
        key: AppConstant.recentPlacesCache,
        value: Global.recentPlaces,
      );
    });

    super.initState();
  }

  void fetchPlaceDetails() async {
    setState(() {
      isLoading = true;
    });
    final placeDetails = await Utils.fetchPlaceDetails(place!.pId!);
    place = place?.copyWith(
      reviewsResult: ReviewResult.fromJson(placeDetails['result']),
    );
    // update firebase with the new place details
    // FirebaseFirestore.instance.collection("places").doc(place!.pId).set(
    //       place!.toJson(),
    //     );

    if (context.mounted)
      setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: SpinKitFoldingCube(
                color: AppColors.primary,
                size: 50.0,
              ),
            )
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ).r,
                  ),
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                  expandedHeight: 300.0.spMin,
                  backgroundColor: AppColors.grey.withOpacity(0.5),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: CarouselSlider(
                            items: place?.imageUrls!
                                .map(
                                  (e) => ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ).r,
                                    child: CachedNetworkImage(
                                      imageUrl: e,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: 350.0.spMin,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              autoPlay: true,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              if (kUser != null) {
                                context.read<PlacesBloc>().add(
                                      ToggleFav(
                                        place: place!,
                                      ),
                                    );

                                setState(() {
                                  isFav = !isFav;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: kText(
                                      text: "You must login first",
                                      color: AppColors.white,
                                    ),
                                    backgroundColor: Colors.black,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grey.withOpacity(0.5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ).r,
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floating: false,
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // header name
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: kText(
                                          text: place?.name ?? "",
                                          fontSize: 20.spMin,
                                          maxLines: 2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      responsive.sizedBoxW10,
                                      GestureDetector(
                                        onTap: () {
                                          // open google maps
                                          Utils.openGoogleMaps(
                                            lat: place?.lat != null
                                                ? double.parse(place!.lat!)
                                                : Global.ksaLocation.lat,
                                            long: place?.lng != null
                                                ? double.parse(place!.lng!)
                                                : Global.ksaLocation.lng,
                                          );
                                        },
                                        child: Icon(
                                          Icons.location_on,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[900],
                                    ),
                                    kText(
                                      text: place?.reviewsResult?.rating != null
                                          ? place!.reviewsResult!.rating
                                              .toString()
                                          : "0.0",
                                      fontSize: 14.spMin,
                                      color: AppColors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // header description
                            kText(
                              text: place?.address ?? "",
                              fontSize: 14.spMin,
                              maxLines: 3,
                              color: AppColors.grey,
                            ),

                            SizedBox(height: 16.spMin),
                            // header location
                            buildSection(
                              title: "Description: ",
                              value: place?.description ?? "",
                            ),
                            SizedBox(height: 8.spMin),
                            if (place?.reviewsResult?.reviews != null &&
                                place!.reviewsResult!.reviews!.isNotEmpty)

                              // header location
                              buildReviewsSections(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      // add fab
      floatingActionButton: isAdd
          ? null
          : FloatingActionButton(
              onPressed: () {
                // add to one of the trips i have created
                // check if i have only one trip
                if ((Global.kTrips.length + Global.kSharedTrips.length) == 1) {
                  if (Global.kTrips[0].destinations!.length == 1) {
                    // add the place to the trip
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelectData(
                          place: place!,
                          trip: Global.kTrips[0],
                          tripDestination: Global.kTrips[0].destinations![0],
                        ),
                      ),
                    );
                  } else {
                    // select the destination
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TripDestinations(
                          place: place!,
                          trip: Global.kTrips[0],
                        ),
                      ),
                    );
                  }
                } else
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPlaceToTrip(
                        place: place!,
                      ),
                    ),
                  );
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  buildReviewsSections() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(4).r,
          child: kText(
            text: "Reviews",
            fontSize: 16.spMin,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.spMin),
        // create dummy reviews
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            final review = place?.reviewsResult!.reviews![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.spMin,
                    backgroundColor: AppColors.primary.withOpacity(0.5),
                    backgroundImage: CachedNetworkImageProvider(
                      review?.profilePhotoUrl ?? "",
                    ),
                  ),
                  SizedBox(width: 8.spMin),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // author name  if biger than 20 char show only 20
                            kText(
                              text: review?.authorName != null
                                  ? (review!.authorName!.length > 15
                                      ? review.authorName!.substring(0, 15) +
                                          ".."
                                      : review.authorName!)
                                  : "Anonymous",
                              fontSize: 14.spMin,
                              fontWeight: FontWeight.bold,
                            ),
                            kText(
                              text: review?.relativeTimeDescription != null
                                  ? (review!.relativeTimeDescription!.length >
                                          15
                                      ? review.relativeTimeDescription!
                                              .substring(0, 15) +
                                          ".."
                                      : review.relativeTimeDescription!)
                                  : "Just Now",
                              fontSize: 14.spMin,
                              maxLines: 10,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                        kText(
                          text: review?.text ?? "",
                          fontSize: 14.spMin,
                          maxLines: 10,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: place?.reviewsResult!.reviews!.length,
        ),
        SizedBox(height: 8.spMin),
      ],
    );
  }

  buildSection({
    required String title,
    required String value,
    String? value2,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(4).r,
          child: kText(
            text: title,
            fontSize: 16.spMin,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.spMin),
        if (value2 != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: Row(
              children: [
                Row(
                  children: [
                    kText(
                      text: "Latitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(width: 8.spMin),
                Row(
                  children: [
                    kText(
                      text: "Longitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value2).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (value2 == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: kText(
              text: value,
              fontSize: 14.spMin,
              maxLines: 10,
              color: AppColors.grey,
            ),
          ),
      ],
    );
  }
}
