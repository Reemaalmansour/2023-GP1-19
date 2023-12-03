import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/visited_places_model.dart';

import '../../model/trip_model.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripLoading()) {
    // on<LoadTrips>(_onLoadTrips);
    on<LoadTrips>(_onLoadTrips);
    on<AddTrip>(_onAddTrip);
    on<UpdateTrip>(_onUpdateTrip);
    on<DeleteTrip>(_onDeleteTrip);
    on<FetchAndUpdateTheTrip>(_fetchAndUpdateTheTrip);

    on<AddVisitedPlaceToTripDestination>(_onAddVisitedPlaceToTripDestination);
    on<AddDestinationToTheTrip>(_onAddDestinationToTheTrip);
    on<UpdateDestination>(_onUpdateDestination);
    on<DeleteDestination>(_onDeleteDestination);
    on<RemoveVisitedPlaceFromTripDestination>(
      _onRemoveVisitedPlaceFromTripDestination,
    );

    // on<OnSearchDestination>(_onTripDestinationSearch);
  }
  static TripBloc get(context) => BlocProvider.of(context);
  List<TripModelN> allTrips = [];

  FutureOr<void> _onLoadTrips(LoadTrips event, Emitter<TripState> emit) async {
    List<TripModelN> trips = [];

    List<String> tripsIds = event.tripsIds;
    emit(TripLoading());

    for (var i in tripsIds) {
      log('UserTripsIds ${i}');
      TripModelN? newTrip;
      try {
        final response =
            await FirebaseFirestore.instance.collection('trips').doc(i).get();
        if (response.exists) {
          final trip = TripModelN.fromJson(response.data()!);

          newTrip = trip;
        }
        newTrip!.destinations = [];
        for (var i in newTrip.destinationsIds!) {
          final response = await FirebaseFirestore.instance
              .collection('destination')
              .doc(i)
              .get();

          if (response.exists) {
            final destination = TripDestination.fromJson(response.data()!);

            newTrip.destinations?.add(destination);
          } else {
            log("destination not found");
          }
        }
      } catch (e) {
        emit(TripFailure(message: e.toString()));
      }
      trips.add(newTrip!);
    }
    for (var i in trips) {
      i.destinations?.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    }
    allTrips = trips;
    emit(TripLoaded(trips: allTrips));
  }

  FutureOr<void> _onAddTrip(AddTrip event, Emitter<TripState> emit) async {
    emit(TripAddLoading());
    try {
      List<String> destinationsDocIds = [];
      final tripDocId = FirebaseFirestore.instance.collection('trips').doc().id;

      for (var i in event.trip.destinations!) {
        final desDocId =
            FirebaseFirestore.instance.collection('destination').doc().id;
        i.tripId = tripDocId;
        i.destinationId = desDocId;
        await FirebaseFirestore.instance
            .collection('destination')
            .doc(desDocId)
            .set(i.toJson());
        destinationsDocIds.add(desDocId);
      }
      event.trip.destinationsIds = destinationsDocIds;
      event.trip.tripId = tripDocId;

      await FirebaseFirestore.instance
          .collection('trips')
          .doc(tripDocId)
          .set(event.trip.toJson());

      kUser?.tripsIds.add(tripDocId);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(kUser!.uId)
          .update(kUser!.toJson());
      allTrips.add(event.trip);
      emit(const TripSuccess(message: "Trip Added Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

//   FutureOr<void> _onTripDestinationSearch(
//       OnSearchDestination event, Emitter<TripState> emit) {}

  FutureOr<void> _onAddVisitedPlaceToTripDestination(
    AddVisitedPlaceToTripDestination event,
    Emitter<TripState> emit,
  ) async {
    emit(TripAddLoading());

    try {
      final destination = event.tripDestination;

      final visitedPlace = event.visitedPlace;
      List<VisitedPlaces> visitedPlaces = destination.visitedPlaces ?? [];
      visitedPlaces.add(visitedPlace);
      destination.visitedPlaces = visitedPlaces;

      await FirebaseFirestore.instance
          .collection('destination')
          .doc(destination.destinationId)
          .update({
        "visitedPlaces": visitedPlaces.map((e) => e.toJson()).toList(),
      });

      allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .destinations
          ?.firstWhere(
            (element) => element.destinationId == destination.destinationId,
          )
          .visitedPlaces = visitedPlaces;
      emit(const TripSuccess(message: "Place Added Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onAddDestinationToTheTrip(
    AddDestinationToTheTrip event,
    Emitter<TripState> emit,
  ) async {
    emit(TripAddLoading());
    try {
      final desDocId =
          FirebaseFirestore.instance.collection('destination').doc().id;
      final updatedTrip = event.updatedTrip;
      List<String> destinationsIds = updatedTrip.destinationsIds ?? [];

      destinationsIds.add(desDocId);

      updatedTrip.destinations!.last.destinationId = desDocId;

      TripDestination lastDestinationAdd = updatedTrip.destinations!.last;

      // updatedTrip.destinations?.add(lastDestinationAdd);

      await FirebaseFirestore.instance
          .collection('destination')
          .doc(desDocId)
          .set(lastDestinationAdd.toJson());

      updatedTrip.destinationsIds = destinationsIds;

      log('updatedTrip ${updatedTrip.tripId}');
      await FirebaseFirestore.instance
          .collection('trips')
          .doc(updatedTrip.tripId)
          .update({
        "destinationsIds": destinationsIds,
      });

      allTrips
          .firstWhere((element) => element.tripId == updatedTrip.tripId)
          .destinations = updatedTrip.destinations;
      emit(const TripSuccess(message: "Destination Added Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onUpdateTrip(UpdateTrip event, Emitter<TripState> emit) {
    emit(TripAddLoading());
    try {
      final updatedTrip = event.updatedTrip;
      FirebaseFirestore.instance
          .collection('trips')
          .doc(updatedTrip.tripId)
          .update(
            updatedTrip.toJson(),
          );
      allTrips
          .firstWhere((element) => element.tripId == updatedTrip.tripId)
          .destinations = updatedTrip.destinations;
      allTrips
          .firstWhere((element) => element.tripId == updatedTrip.tripId)
          .name = updatedTrip.name;
      emit(const TripSuccess(message: "Trip Updated Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onRemoveVisitedPlaceFromTripDestination(
    RemoveVisitedPlaceFromTripDestination event,
    Emitter<TripState> emit,
  ) {
    emit(TripAddLoading());
    try {
      final destination = event.tripDestination;

      int visitedPlaceIndex = event.visitedPlaceIndex;

      VisitedPlaces visitedPlace =
          destination.visitedPlaces![visitedPlaceIndex];

      destination.visitedPlaces!.remove(visitedPlace);

      FirebaseFirestore.instance
          .collection('destination')
          .doc(destination.destinationId)
          .update({
        "visitedPlaces":
            destination.visitedPlaces!.map((e) => e.toJson()).toList(),
      });

      allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .destinations
          ?.firstWhere(
            (element) => element.destinationId == destination.destinationId,
          )
          .visitedPlaces = destination.visitedPlaces;
      emit(const TripSuccess(message: "Place Removed Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onDeleteTrip(DeleteTrip event, Emitter<TripState> emit) {
    emit(TripAddLoading());
    try {
      final trip = event.trip;
      FirebaseFirestore.instance.collection('trips').doc(trip.tripId).delete();

      kUser?.tripsIds.remove(trip.tripId);
      FirebaseFirestore.instance.collection('user').doc(kUser!.uId).update({
        "tripsIds": kUser!.tripsIds,
      });
      allTrips.remove(trip);
      emit(const TripSuccess(message: "Trip Deleted Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onUpdateDestination(
    UpdateDestination event,
    Emitter<TripState> emit,
  ) {
    emit(TripAddLoading());
    try {
      final updatedTrip = event.trip;
      final updatedDestination = event.updatedDestination;
      FirebaseFirestore.instance
          .collection('destination')
          .doc(updatedDestination.destinationId)
          .update(
            updatedDestination.toJson(),
          );
      allTrips
          .firstWhere((element) => element.tripId == updatedTrip.tripId)
          .destinations = updatedTrip.destinations;
      emit(const TripSuccess(message: "Destination Updated Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onDeleteDestination(
    DeleteDestination event,
    Emitter<TripState> emit,
  ) {
    emit(TripAddLoading());
    try {
      final trip = event.trip;
      final destination = event.destination;
      FirebaseFirestore.instance
          .collection('destination')
          .doc(destination.destinationId)
          .delete();

      trip.destinationsIds!.remove(destination.destinationId);

      FirebaseFirestore.instance.collection('trips').doc(trip.tripId).update({
        "destinationsIds": trip.destinationsIds,
      });
      allTrips
          .firstWhere((element) => element.tripId == trip.tripId)
          .destinations
          ?.remove(destination);
      emit(const TripSuccess(message: "Destination Deleted Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }

  FutureOr<void> _fetchAndUpdateTheTrip(
    FetchAndUpdateTheTrip event,
    Emitter<TripState> emit,
  ) {
    emit(TripAddLoading());
    try {
      final trip = event.trip;
      FirebaseFirestore.instance
          .collection('trips')
          .doc(trip.tripId)
          .get()
          .then((value) {
        if (value.exists) {
          final trip = TripModelN.fromJson(value.data()!);
          trip.destinations = [];
          for (var i in trip.destinationsIds!) {
            FirebaseFirestore.instance
                .collection('destination')
                .doc(i)
                .get()
                .then((value) {
              if (value.exists) {
                final destination = TripDestination.fromJson(value.data()!);

                trip.destinations?.add(destination);
              } else {
                log("destination not found");
              }
            });
          }
          allTrips
              .firstWhere((element) => element.tripId == trip.tripId)
              .destinations = trip.destinations;
        }
      });
      emit(const TripSuccess(message: "Trip Updated Successfully"));
      emit(TripLoaded(trips: allTrips));
    } catch (e) {
      emit(TripFailure(message: e.toString()));
    }
  }
}
