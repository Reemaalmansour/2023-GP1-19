import 'package:flutter/material.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/model/trip_place/trip_place_model.dart';

import 'day_time_line.dart';

class TripTimeLine extends StatefulWidget {
  final String tripId;
  final TripDestinationModel tripDestination;

  final TripPlaceModel? addPlace;

  const TripTimeLine({
    super.key,
    required this.tripDestination,
    required this.tripId,
    this.addPlace,
  });

  @override
  State<TripTimeLine> createState() => _TripTimeLineState();
}

class _TripTimeLineState extends State<TripTimeLine> {
  late TripDestinationModel tripDestination = widget.tripDestination;
  late String tripId = widget.tripId;
  late List<DateTime> dateRange;
  late List<TripPlaceModel> visitedPlaces;

  late TripPlaceModel? addPlace;

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
    visitedPlaces = tripDestination.visitedPlaces ?? [];

    addPlace = widget.addPlace;
  }

  @override
  Widget build(BuildContext context) {
    // context.loaderOverlay.hide();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dateRange.length,
      itemBuilder: (context, index) {
        final sameDatePlaces = visitedPlaces
            .where(
              (element) =>
                  element.visitDate!.year == dateRange[index].year &&
                  element.visitDate!.month == dateRange[index].month &&
                  element.visitDate!.day == dateRange[index].day,
            )
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
        // String createdName = visitedPlaces[index].place.createdBy!.name!;
        return DayTimeLine(
          date: dateRange[index],
          tripDestination: tripDestination,
          visitedPlaces: sameDatePlaces,
          addPlace: addPlace,
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
}
