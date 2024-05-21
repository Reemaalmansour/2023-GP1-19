import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '/global/global.dart';
import '/model/place/place_model.dart';
import '/shared/component/k_text.dart';

import '../../model/trip/trip_model.dart';
import 'select_destination/select_destination.dart';

class AddPlaceToTrip extends StatefulWidget {
  final PlaceModel place;
  const AddPlaceToTrip({super.key, required this.place});

  @override
  State<AddPlaceToTrip> createState() => _AddPlaceToTripState();
}

class _AddPlaceToTripState extends State<AddPlaceToTrip> {
  late PlaceModel place;
  List<TripModel> allTrips = [];

  @override
  void initState() {
    place = widget.place;
    // add all Global.kTrips  Global.kSharedTrips
    allTrips = Global.kTrips + Global.kSharedTrips;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kText(text: 'Select Trip '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
        child: ListView.builder(
          itemCount: allTrips.length,
          itemBuilder: (context, index) {
            final trip = allTrips[index];
            return Card(
              elevation: 1,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: trip.destinations != null &&
                          trip.destinations!.isNotEmpty &&
                          trip.destinations![0].image != null &&
                          trip.destinations![0].image!.isNotEmpty &&
                          trip.destinations![0].image?[0] != null
                      ? CachedNetworkImageProvider(
                          trip.destinations![0].image![0],
                        )
                      : null,
                ),
                title: kText(text: trip.name!),
                subtitle: kText(
                  text: "created by " + (trip.createdBy?.name ?? "Unknown"),
                ),
                // date as Jan 12, 2021
                trailing: kText(
                  text: trip.createOn != null
                      ? DateFormat.yMMMd().format(trip.createOn!)
                      : "",
                  fontSize: 10,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TripDestinations(
                        trip: trip,
                        place: place,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
