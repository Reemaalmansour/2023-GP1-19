import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/place/place_model.dart';
import '/model/trip/trip_model.dart';
import '/shared/component/k_text.dart';

import '../../../model/trip_destination/trip_destination_model.dart';
import '../select_date/select_date.dart';

class TripDestinations extends StatefulWidget {
  final PlaceModel place;
  final TripModel trip;
  const TripDestinations({super.key, required this.trip, required this.place});

  @override
  State<TripDestinations> createState() => _TripDestinationsState();
}

class _TripDestinationsState extends State<TripDestinations> {
  late TripModel trip;
  late PlaceModel place;
  List<TripDestinationModel> destinations = [];

  @override
  void initState() {
    trip = widget.trip;
    destinations = trip.destinations ?? [];
    place = widget.place;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select  Destinations'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  TripDestinationModel destination = destinations[index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   backgroundImage:
                      //       destination.visitedPlaces?[0].imageUrls != null &&
                      //               destination
                      //                   .visitedPlaces![0].imageUrls!.isNotEmpty
                      //           ? CachedNetworkImageProvider(
                      //               destination.visitedPlaces![0].imageUrls![0],
                      //             )
                      //           : null, // place.imageUrls![0]
                      // ),
                      title: kText(text: destination.name ?? ''),
                      // from - to date as Jan 12, 2021 - Jan 15, 2021
                      subtitle: Text(
                        '${destination.startDate != null ? DateFormat.yMMMd().format(destination.startDate!) : ''} - ${destination.leaveDate != null ? DateFormat.yMMMd().format(destination.leaveDate!) : ''}',
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectData(
                              trip: trip,
                              tripDestination: destination,
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
            // add destination button
          ],
        ),
      ),
    );
  }
}
