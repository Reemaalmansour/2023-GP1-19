// part of 'trip_bloc.dart';

// sealed class TripEvent extends Equatable {
//   const TripEvent();

//   @override
//   List<Object> get props => [];
// }

// final class LoadTrips extends TripEvent {}

// final class LoadSharedTrips extends TripEvent {}

// class AddTrip extends TripEvent {
//   final TripModel trip;

//   AddTrip({
//     required this.trip,
//   });

//   @override
//   List<Object> get props => [trip];
// }

// class FetchAndUpdateTheTrip extends TripEvent {
//   final TripModel trip;

//   FetchAndUpdateTheTrip({
//     required this.trip,
//   });

//   @override
//   List<Object> get props => [trip];
// }

// final class UpdateTrip extends TripEvent {
//   final TripModel updatedTrip;

//   UpdateTrip({
//     required this.updatedTrip,
//   });

//   @override
//   List<Object> get props => [updatedTrip];
// }

// final class DeleteTrip extends TripEvent {
//   final TripModel trip;

//   DeleteTrip({
//     required this.trip,
//   });

//   @override
//   List<Object> get props => [trip];
// }

// final class ToggleFav extends TripEvent {
//   final TripModel trip;

//   ToggleFav({
//     required this.trip,
//   });

//   @override
//   List<Object> get props => [trip];
// }

// final class AddDestination extends TripEvent {
//   final TripModel trip;
//   final TripDestinationModel destination;

//   AddDestination({
//     required this.trip,
//     required this.destination,
//   });

//   @override
//   List<Object> get props => [trip, destination];
// }

// final class UpdateDestination extends TripEvent {
//   final TripModel trip;
//   final TripDestinationModel updatedDestination;

//   UpdateDestination({
//     required this.trip,
//     required this.updatedDestination,
//   });

//   @override
//   List<Object> get props => [trip, updatedDestination];
// }

// final class DeleteDestination extends TripEvent {
//   final TripModel trip;
//   final TripDestinationModel destination;

//   DeleteDestination({
//     required this.trip,
//     required this.destination,
//   });

//   @override
//   List<Object> get props => [trip, destination];
// }

// final class AddDestinationToTheTrip extends TripEvent {
//   final TripModel updatedTrip;

//   AddDestinationToTheTrip({
//     required this.updatedTrip,
//   });

//   @override
//   List<Object> get props => [updatedTrip];
// }

// final class AddVisitedPlaceToTripDestination extends TripEvent {
//   final TripDestinationModel tripDestination;
//   final VisitedPlaceModel visitedPlace;

//   const AddVisitedPlaceToTripDestination({
//     required this.tripDestination,
//     required this.visitedPlace,
//   });

//   @override
//   List<Object> get props => [tripDestination, visitedPlace];
// }

// final class RemoveVisitedPlaceFromTripDestination extends TripEvent {
//   final VisitedPlaceModel place;
//   final TripDestinationModel tripDestination;

//   const RemoveVisitedPlaceFromTripDestination({
//     required this.place,
//     required this.tripDestination,
//   });

//   @override
//   List<Object> get props => [place, tripDestination];
// }
