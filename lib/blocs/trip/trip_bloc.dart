// import 'dart:async';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/global/global.dart';
// import '/model/trip/trip_model.dart';
// import '/model/trip_destination/trip_destination_model.dart';
// // import '/model/visited_place/visited_place_model.dart';

// import '../../resources/constant_maneger.dart';

// part 'trip_event.dart';
// part 'trip_state.dart';

// class TripBloc extends Bloc<TripEvent, TripState> {
//   TripBloc() : super(TripLoading()) {
//     // on<LoadTrips>(_onLoadTrips);
//     on<LoadTrips>(_onLoadTrips);
//     on<AddTrip>(_onAddTrip);
//     on<UpdateTrip>(_onUpdateTrip);
//     on<DeleteTrip>(_onDeleteTrip);
//     on<FetchAndUpdateTheTrip>(_fetchAndUpdateTheTrip);

//     on<AddVisitedPlaceToTripDestination>(_onAddVisitedPlaceToTripDestination);
//     on<AddDestinationToTheTrip>(_onAddDestinationToTheTrip);
//     on<UpdateDestination>(_onUpdateDestination);
//     on<DeleteDestination>(_onDeleteDestination);
//     on<RemoveVisitedPlaceFromTripDestination>(
//       _onRemoveVisitedPlaceFromTripDestination,
//     );
//     on<LoadSharedTrips>(_onLoadSharedTrips);

//     // on<OnSearchDestination>(_onTripDestinationSearch);
//   }
//   static TripBloc get(context) => BlocProvider.of(context);
//   List<TripModel> allTrips = [];

//   FutureOr<void> _onLoadTrips(LoadTrips event, Emitter<TripState> emit) async {
//     emit(TripLoading());
//     try {
//       List<TripModel> trips = [];
//       for (var i in kUser!.tripsIds!) {
//         await FirebaseFirestore.instance
//             .collection(AppConstant.tripsCollection)
//             .doc(i)
//             .get()
//             .then((value) async {
//           if (value.exists) {
//             final trip = TripModel.fromJson(value.data()!);
//             trip.destinations = [];
//             for (var i in trip.destinationsIds!) {
//               await FirebaseFirestore.instance
//                   .collection(AppConstant.destinationsCollection)
//                   .doc(i)
//                   .get()
//                   .then((value) {
//                 if (value.exists) {
//                   final destination =
//                       TripDestinationModel.fromJson(value.data()!);
//                   trip.destinations!.add(destination);
//                 } else {
//                   log("destination not found");
//                 }
//               });
//             }
//             trips.add(trip);
//           }
//         });
//       }
//       // sort trips by date
//       trips.sort((a, b) => a.createOn!.compareTo(b.createOn!));
//       allTrips = trips;
//       emit(TripLoaded(trips: allTrips));
//     } catch (error) {
//       emit(TripFailure(message: error.toString()));
//       log("error from _onLoadTrips ${error.toString()}");
//     }
//   }

//   FutureOr<void> _onAddTrip(AddTrip event, Emitter<TripState> emit) async {
//     TripModel trip = event.trip;
//     emit(TripAddLoading());

//     try {
//       String destinationId = trip.destinations!.first.destinationId!;
//       TripDestinationModel destination = trip.destinations!.first;

//       await FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(destinationId)
//           .set(destination.toJson());

//       await FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(trip.tripId)
//           .set(trip.toJson());

//       kUser!.tripsIds!.add(trip.tripId!);

//       await FirebaseFirestore.instance
//           .collection(AppConstant.usersCollection)
//           .doc(kUser!.uId)
//           .update(kUser!.toJson());

//       allTrips.add(trip);
//       emit(const TripSuccess(message: "Trip Added Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//       log("error from _onAddTrip ${e.toString()}");
//     }
//   }

// //   FutureOr<void> _onTripDestinationSearch(
// //       OnSearchDestination event, Emitter<TripState> emit) {}

//   FutureOr<void> _onAddVisitedPlaceToTripDestination(
//     AddVisitedPlaceToTripDestination event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripAddLoading());

//     try {
//       final destination = event.tripDestination;
//       final visitedPlace = event.visitedPlace;
//       log('destination ${destination.destinationId}');
//       await FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(destination.destinationId)
//           .update({
//         "visitedPlaces": FieldValue.arrayUnion([
//           visitedPlace.toJson(),
//         ]),
//       });

//       destination.visitedPlaces?.add(visitedPlace);
//       List<TripDestinationModel> updatedDestinations = List.from(
//         allTrips
//             .firstWhere((element) => element.tripId == destination.tripId)
//             .destinations!,
//       );
//       updatedDestinations.remove(destination);
//       updatedDestinations.add(destination);
//       TripModel updatedTrip = allTrips
//           .firstWhere((element) => element.tripId == destination.tripId)
//           .copyWith(destinations: updatedDestinations);

//       allTrips.removeWhere((element) => element.tripId == destination.tripId);
//       allTrips.add(updatedTrip);
//       emit(const TripSuccess(message: "Place Added Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//       log("error from _onAddVisitedPlaceToTripDestination ${e.toString()}");
//     }
//   }

//   FutureOr<void> _onAddDestinationToTheTrip(
//     AddDestinationToTheTrip event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripAddLoading());
//     try {
//       final updatedTrip = event.updatedTrip;
//       log('updatedTrip ${updatedTrip}');

//       // updatedTrip.destinations?.add(lastDestinationAdd);

//       await FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(updatedTrip.destinationsIds!.last)
//           .set(updatedTrip.destinations!.last.toJson());

//       log('updatedTrip ${updatedTrip.tripId}');
//       await FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(updatedTrip.tripId)
//           .update({
//         "destinationsIds": FieldValue.arrayUnion([
//           updatedTrip.destinationsIds!.last,
//         ]),
//       });

//       // update trip in all trips
//       allTrips.removeWhere((element) => element.tripId == updatedTrip.tripId);
//       allTrips.add(updatedTrip);
//       emit(const TripSuccess(message: "Destination Added Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onUpdateTrip(
//     UpdateTrip event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripAddLoading());
//     try {
//       final updatedTrip = event.updatedTrip;
//       await FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(updatedTrip.tripId)
//           .update(
//             updatedTrip.toJson(),
//           );

//       final selectedTrip = allTrips
//           .firstWhere((element) => element.tripId == updatedTrip.tripId);
//       final updateTrip = selectedTrip.copyWith(
//         name: updatedTrip.name,
//         destinations: List.from(updatedTrip.destinations ?? []),
//         destinationsIds: List.from(updatedTrip.destinationsIds ?? []),
//       );
//       allTrips.remove(selectedTrip);
//       allTrips.add(updateTrip);

//       emit(const TripSuccess(message: "Trip Updated Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onRemoveVisitedPlaceFromTripDestination(
//     RemoveVisitedPlaceFromTripDestination event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripAddLoading());
//     try {
//       TripDestinationModel destination = event.tripDestination;
//       // VisitedPlaceModel place = event.place;

//       TripDestinationModel uDestination = destination.copyWith(
//         visitedPlaces: List.from(destination.visitedPlaces ?? [])
//           ..remove(place),
//       );

//       List<TripDestinationModel> listDestinations = List.from(
//         allTrips
//             .firstWhere((element) => element.tripId == destination.tripId)
//             .destinations!,
//       );
//       listDestinations.remove(destination);
//       listDestinations.add(uDestination);

//       TripModel updatedTrip = allTrips
//           .firstWhere((element) => element.tripId == destination.tripId)
//           .copyWith(destinations: listDestinations);

//       allTrips.removeWhere((element) => element.tripId == destination.tripId);
//       allTrips.add(updatedTrip);

//       await FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(uDestination.destinationId)
//           .update({
//         "visitedPlaces":
//             uDestination.visitedPlaces?.map((e) => e.toJson()).toList(),
//       });

//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onDeleteTrip(
//     DeleteTrip event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripAddLoading());
//     try {
//       final trip = event.trip;
//       //delete all destinations
//       for (var i in trip.destinationsIds!) {
//         await FirebaseFirestore.instance
//             .collection(AppConstant.destinationsCollection)
//             .doc(i)
//             .delete();
//       }
//       //delete trip
//       await FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(trip.tripId)
//           .delete();
//       //delete trip from user
//       kUser?.tripsIds?.remove(trip.tripId);
//       // update user in firestore
//       FirebaseFirestore.instance
//           .collection(AppConstant.usersCollection)
//           .doc(kUser!.uId)
//           .update({
//         "tripsIds": kUser!.tripsIds,
//       });
//       // update all trips
//       allTrips.remove(trip);
//       emit(const TripSuccess(message: "Trip Deleted Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onUpdateDestination(
//     UpdateDestination event,
//     Emitter<TripState> emit,
//   ) {
//     emit(TripAddLoading());
//     try {
//       final updatedTrip = event.trip;
//       final updatedDestination = event.updatedDestination;
//       FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(updatedDestination.destinationId)
//           .update(
//             updatedDestination.toJson(),
//           );
//       // remove old destination
//       allTrips
//           .firstWhere((element) => element.tripId == updatedTrip.tripId)
//           .destinations
//           ?.removeWhere(
//             (element) =>
//                 element.destinationId == updatedDestination.destinationId,
//           );
//       // add updated destination
//       allTrips
//           .firstWhere((element) => element.tripId == updatedTrip.tripId)
//           .destinations
//           ?.add(updatedDestination);
//       emit(const TripSuccess(message: "Destination Updated Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onDeleteDestination(
//     DeleteDestination event,
//     Emitter<TripState> emit,
//   ) {
//     emit(TripAddLoading());
//     try {
//       final trip = event.trip;
//       final destination = event.destination;
//       FirebaseFirestore.instance
//           .collection(AppConstant.destinationsCollection)
//           .doc(destination.destinationId)
//           .delete();

//       trip.destinationsIds!.remove(destination.destinationId);

//       FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(trip.tripId)
//           .update({
//         "destinationsIds": trip.destinationsIds,
//       });
//       allTrips
//           .firstWhere((element) => element.tripId == trip.tripId)
//           .destinations
//           ?.remove(destination);
//       emit(const TripSuccess(message: "Destination Deleted Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _fetchAndUpdateTheTrip(
//     FetchAndUpdateTheTrip event,
//     Emitter<TripState> emit,
//   ) {
//     emit(TripAddLoading());
//     try {
//       final trip = event.trip;
//       FirebaseFirestore.instance
//           .collection(AppConstant.tripsCollection)
//           .doc(trip.tripId)
//           .get()
//           .then((value) {
//         if (value.exists) {
//           final trip = TripModel.fromJson(value.data()!);

//           for (var i in trip.destinationsIds!) {
//             FirebaseFirestore.instance
//                 .collection(AppConstant.destinationsCollection)
//                 .doc(i)
//                 .get()
//                 .then((value) {
//               if (value.exists) {
//                 final destination =
//                     TripDestinationModel.fromJson(value.data()!);

//                 trip.destinations?.add(destination);
//               } else {
//                 log("destination not found");
//               }
//             });
//           }
//           allTrips
//               .firstWhere((element) => element.tripId == trip.tripId)
//               .destinations
//               ?.clear();
//           allTrips
//               .firstWhere((element) => element.tripId == trip.tripId)
//               .destinations
//               ?.addAll(trip.destinations!);
//         }
//       });
//       emit(const TripSuccess(message: "Trip Updated Successfully"));
//       emit(TripLoaded(trips: allTrips));
//     } catch (e) {
//       emit(TripFailure(message: e.toString()));
//     }
//   }

//   FutureOr<void> _onLoadSharedTrips(
//     LoadSharedTrips event,
//     Emitter<TripState> emit,
//   ) async {
//     emit(TripLoading());
//     try {
//       List<TripModel> trips = [];
//       for (var i in kUser!.sharedTripsIds!) {
//         await FirebaseFirestore.instance
//             .collection(AppConstant.tripsCollection)
//             .doc(i)
//             .get()
//             .then((value) async {
//           if (value.exists) {
//             final trip = TripModel.fromJson(value.data()!);
//             trip.destinations = [];
//             for (var i in trip.destinationsIds!) {
//               await FirebaseFirestore.instance
//                   .collection(AppConstant.destinationsCollection)
//                   .doc(i)
//                   .get()
//                   .then((value) {
//                 if (value.exists) {
//                   final destination =
//                       TripDestinationModel.fromJson(value.data()!);
//                   trip.destinations!.add(destination);
//                 } else {
//                   log("destination not found");
//                 }
//               });
//             }
//             trips.add(trip);
//           }
//         });
//       }
//       // sort trips by date
//       trips.sort((a, b) => a.createOn!.compareTo(b.createOn!));
//       allTrips = trips;
//       emit(TripLoaded(trips: allTrips));
//     } catch (error) {
//       emit(TripFailure(message: error.toString()));
//       log("error from _onLoadTrips ${error.toString()}");
//     }
//   }
// }
