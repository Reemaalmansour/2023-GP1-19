part of 'trip_bloc.dart';

sealed class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

final class LoadTrips extends TripEvent {
  final List<String> tripsIds;

  LoadTrips({
    this.tripsIds = const <String>[],
  });

  @override
  List<Object> get props => [tripsIds];
}

class AddTrip extends TripEvent {
  final TripModelN trip;

  AddTrip({
    required this.trip,
  });

  @override
  List<Object> get props => [trip];
}

class FetchAndUpdateTheTrip extends TripEvent {
  final TripModelN trip;

  FetchAndUpdateTheTrip({
    required this.trip,
  });

  @override
  List<Object> get props => [trip];
}

final class UpdateTrip extends TripEvent {
  final TripModelN updatedTrip;

  UpdateTrip({
    required this.updatedTrip,
  });

  @override
  List<Object> get props => [updatedTrip];
}

final class DeleteTrip extends TripEvent {
  final TripModelN trip;

  DeleteTrip({
    required this.trip,
  });

  @override
  List<Object> get props => [trip];
}

final class ToggleFav extends TripEvent {
  final TripModelN trip;

  ToggleFav({
    required this.trip,
  });

  @override
  List<Object> get props => [trip];
}

final class AddDestination extends TripEvent {
  final TripModelN trip;
  final TripDestination destination;

  AddDestination({
    required this.trip,
    required this.destination,
  });

  @override
  List<Object> get props => [trip, destination];
}

final class UpdateDestination extends TripEvent {
  final TripModelN trip;
  final TripDestination updatedDestination;

  UpdateDestination({
    required this.trip,
    required this.updatedDestination,
  });

  @override
  List<Object> get props => [trip, updatedDestination];
}

final class DeleteDestination extends TripEvent {
  final TripModelN trip;
  final TripDestination destination;

  DeleteDestination({
    required this.trip,
    required this.destination,
  });

  @override
  List<Object> get props => [trip, destination];
}

final class AddDestinationToTheTrip extends TripEvent {
  final TripModelN updatedTrip;

  AddDestinationToTheTrip({
    required this.updatedTrip,
  });

  @override
  List<Object> get props => [updatedTrip];
}

final class AddVisitedPlaceToTripDestination extends TripEvent {
  final TripDestination tripDestination;
  final VisitedPlaces visitedPlace;

  const AddVisitedPlaceToTripDestination({
    required this.tripDestination,
    required this.visitedPlace,
  });

  @override
  List<Object> get props => [tripDestination, visitedPlace];
}

final class RemoveVisitedPlaceFromTripDestination extends TripEvent {
  final int visitedPlaceIndex;
  final TripDestination tripDestination;

  const RemoveVisitedPlaceFromTripDestination({
    required this.visitedPlaceIndex,
    required this.tripDestination,
  });

  @override
  List<Object> get props => [visitedPlaceIndex, tripDestination];
}
