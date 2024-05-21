import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/trip_destination/trip_destination_model.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../../model/comment/comment_model.dart';
import '../../model/place/place_model.dart';
import '../../model/trip_place/trip_place_model.dart';
import '../../shared/component/k_text.dart';
import '/presentation/places%20details/places_details.dart';

class VisitedPlaceCard extends StatefulWidget {
  final TripPlaceModel place;
  final bool? isAdd;
  final TripDestinationModel tripDestination;
  const VisitedPlaceCard({
    super.key,
    required this.place,
    this.isAdd,
    required this.tripDestination,
  });

  @override
  State<VisitedPlaceCard> createState() => _VisitedPlaceCardState();
}

class _VisitedPlaceCardState extends State<VisitedPlaceCard> {
  late TripDestinationModel tripDestination;
  late TripPlaceModel place;
  late String createdName;
  late bool? isAdd;
  Color color = const Color.fromARGB(255, 255, 169, 169);
  List<CommentModel> comments = [];
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    tripDestination = widget.tripDestination;
    place = widget.place;
    createdName = place.createdBy?.name ?? "Unknown";
    isAdd = widget.isAdd;
    comments = place.comments ?? [];
    // sort it by date time newest first
    comments.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    super.initState();

    // Start the color transition after 1 second
    Timer(const Duration(seconds: 1), () {
      setState(() {
        color = Colors.white;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // show bar model sheet // to see comments
        showBarModalBottomSheet(
          context: context,
          builder: (context) {
            bool isLoading = false;
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: responsive.sHeight(context) * 0.7,
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              responsive.sizedBoxH10,
                              kText(
                                text: "Comments",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              Expanded(
                                child: isLoading
                                    ? Center(
                                        child: SpinKitCubeGrid(
                                          color: AppColors.primary,
                                          size: 50.0,
                                        ),
                                      )
                                    : comments.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: comments.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                // if image is null show  first letter of name
                                                leading: CircleAvatar(
                                                  backgroundImage: comments[
                                                                  index]
                                                              .createdBy!
                                                              .imageUrl !=
                                                          null
                                                      ? CachedNetworkImageProvider(
                                                          comments[index]
                                                              .createdBy!
                                                              .imageUrl!,
                                                        )
                                                      : null,
                                                  child: comments[index]
                                                              .createdBy!
                                                              .imageUrl ==
                                                          null
                                                      ? kText(
                                                          text: comments[index]
                                                              .createdBy!
                                                              .name![0],
                                                        )
                                                      : null,
                                                ),
                                                title: kText(
                                                  text: comments[index]
                                                      .createdBy!
                                                      .name!,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                subtitle: kText(
                                                  text:
                                                      comments[index].content!,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                // show time of comment time ago format

                                                trailing: kText(
                                                  text: Utils.timeAgo(
                                                    comments[index].createdAt!,
                                                  ),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              );
                                            },
                                          )
                                        : const Center(
                                            child: Text("No Comments"),
                                          ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    hintText: "Add Comment",
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  // add comment
                                  setState(() {
                                    isLoading = true;
                                    final comment = CommentModel(
                                      id: DateTime.now().toString(),
                                      content: commentController.text,
                                      createdBy: kUser,
                                      createdAt: DateTime.now(),
                                    );
                                    comments = [comment, ...comments];
                                    commentController.clear();
                                    // update comments in place
                                    place = place.copyWith(comments: comments);
                                  });
                                  await Utils
                                      .onUpdateVisitedPlaceToTripDestination(
                                    destination: tripDestination,
                                    visitedPlace: place,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      onTap: () {
        PlaceModel placeModel = PlaceModel(
          pId: place.pId,
          name: place.name,
          description: place.description,
          imageUrls: place.imageUrls,
          address: place.address,
          lat: place.lat,
          lng: place.lng,
          image: place.imageUrls![0],
          types: place.types,
          isFav: false,
        );
        // navigate to place details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlacesDetails(
                place: placeModel,
                isAdd: true,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 5),
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: (isAdd ?? false) ? color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        place.imageUrls != null && place.imageUrls!.isNotEmpty
                            ? CachedNetworkImageProvider(
                                place.imageUrls![0],
                              )
                            : null, // place.imageUrls![0]
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(
                            text: place.name!,
                            fontSize: 16,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                          ),
                          //
                          kText(
                            text: place.description!,
                            fontSize: 14,
                            maxLines: 2,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          // format dat jan 1, 2021
                          kText(
                            text:
                                "@${createdName}  ${Utils.timeAgo(place.createdAt!)}",
                            fontSize: 11.spMin,
                            maxLines: 1,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // add 3 comments if available
                  if (comments.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < comments.length; i++)
                          if (i < 2)
                            CircleAvatar(
                              radius: 10,
                              backgroundImage:
                                  comments[i].createdBy!.imageUrl != null
                                      ? CachedNetworkImageProvider(
                                          comments[i].createdBy!.imageUrl!,
                                        )
                                      : null,
                              child: comments[i].createdBy!.imageUrl == null
                                  ? kText(
                                      text: comments[i].createdBy!.name![0],
                                    )
                                  : null,
                            ),

                        // if more than 3 comments show more
                        if (comments.length > 2)
                          kText(
                            text: "+${comments.length - 2} more",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                      ],
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
