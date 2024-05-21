import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import '/global/global.dart';

import '../../model/place/place_model.dart';
import '../../resources/constant_maneger.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesLoading()) {
    on<LoadPlaces>(_onLoadPlace);
    on<UpdatePlace>(_onUpdatePlace);
    on<ToggleFav>(_onToggleFav);
    on<AddPlace>(_onAddPlace);
    on<OnSearchAndAddToList>(_onSearchAndAddToList);
    on<removeAllFavPlaces>(_onRemoveAllFavPlaces);
  }
  // List<PlaceModel> favPlaces = [];
  List<PlaceModel> allPlaces = [];

  static PlacesBloc get(context) => BlocProvider.of(context);

  FutureOr<void> _onLoadPlace(
    LoadPlaces event,
    Emitter<PlacesState> emit,
  ) async {
    print("response.docs.isNotEmpty");
    log("response.docs.isNotEmpty");
    List<PlaceModel> places = [];
    emit(PlacesLoading());
    try {
      final response =
          await FirebaseFirestore.instance.collection('places').get();
      if (response.docs.isNotEmpty) {
        var data = response.docs;
        for (var item in data) {
          PlaceModel place = PlaceModel.fromJson(item.data());

          if (kUser != null && kUser!.favPlacesIds!.contains(item.id)) {
            final updatePlace = place.copyWith(isFav: true);
            // add updated place
            places.add(updatePlace);
          } else {
            final updatePlace = place.copyWith(isFav: false);
            // add updated place
            places.add(updatePlace);
          }
          // add place
        }
      } else {
        emit(const PlacesError(message: "No places found"));
      }
    } catch (e) {
      emit(PlacesError(message: e.toString()));
    }
    allPlaces = places;
    emit(PlacesLoaded(places: allPlaces));
  }

  FutureOr<void> _onUpdatePlace(UpdatePlace event, Emitter<PlacesState> emit) {}

  FutureOr<void> _onToggleFav(
    ToggleFav event,
    Emitter<PlacesState> emit,
  ) async {
    PlaceModel place = event.place;
    List<String>? newFavIds = List.from(kUser!.favPlacesIds!);
    emit(PlacesLoading());
    try {
      if (newFavIds.contains(place.pId)) {
        newFavIds.remove(place.pId);
      } else {
        newFavIds.add(place.pId!);
      }

      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(kUser!.uId)
          .update({
        "favPlacesIds": newFavIds,
      });
      // update local user
      kUser = kUser!.copyWith(favPlacesIds: newFavIds);
      // update place
      final updatePlace = place.copyWith(isFav: !place.isFav!);
      // remove old place
      allPlaces.remove(place);
      // add updated place
      allPlaces.add(updatePlace);
      emit(PlacesLoaded(places: allPlaces));
    } catch (e) {
      emit(PlacesError(message: e.toString()));
      log(
        "_onToggleFav" + e.toString(),
      );
    }
  }

  FutureOr<void> _onAddPlace(AddPlace event, Emitter<PlacesState> emit) {
    PlaceModel place = event.place;
    emit(PlacesLoading());
    allPlaces.add(place);
    emit(PlacesLoaded(places: allPlaces));
  }

  FutureOr<void> _onSearchAndAddToList(
    OnSearchAndAddToList event,
    Emitter<PlacesState> emit,
  ) async {
    Prediction? place = event.place;
    BuildContext? context = event.context;
    bool isFav = event.isFav;
    if (place != null) {
      emit(PlacesLoading());
      final plist = GoogleMapsPlaces(
        apiKey: AppConstant.apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      log("plist ${plist} ");
      String placeid = place.placeId ?? "0";
      PlacesDetailsResponse detail = await plist.getDetailsByPlaceId(placeid);
      List<String> photos = [];
      log("detail ${detail.result.types.toString()} ");

      for (var item in detail.result.photos) {
        String photoReference = item.photoReference;
        String photoUrl =
            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${AppConstant.apiKey}';
        photos.add(photoUrl);
      }

      final geometry = detail.result.geometry!;
      final lat = geometry.location.lat;
      final lang = geometry.location.lng;

      var newPlace = PlaceModel(
        pId: placeid,
        name: detail.result.name,
        lat: lat.toString(),
        lng: lang.toString(),
        address: place.description.toString(),
        description: place.description.toString(),
        image: "",
        imageUrls: photos,
        isFav: isFav,
        types: detail.result.types,
      );
      // log("newPlace ${newPlace}");
      var firebasePlace = PlaceModel(
        pId: placeid,
        name: detail.result.name,
        lat: lat.toString(),
        lng: lang.toString(),
        address: place.description.toString(),
        description: place.description.toString(),
        image: "",
        imageUrls: photos,
        isFav: false,
        types: detail.result.types,
      );
      AddPlace event = AddPlace(place: newPlace);
      await FirebaseFirestore.instance
          .collection('places')
          .doc(firebasePlace.pId)
          .set(firebasePlace.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(kUser!.uId)
          .update({
        "favPlacesIds": FieldValue.arrayUnion([firebasePlace.pId]),
      });
      List<String> newFavIds = List.from(kUser!.favPlacesIds!);
      newFavIds.add(firebasePlace.pId!);
      // update local user
      kUser = kUser!.copyWith(
        favPlacesIds: newFavIds,
      );

      //* add place to the list
      context?.read<PlacesBloc>().add(event);
    }
  }

  FutureOr<void> _onRemoveAllFavPlaces(
    removeAllFavPlaces event,
    Emitter<PlacesState> emit,
  ) {
    emit(PlacesLoading());
    allPlaces.forEach((element) {
      element.isFav = false;
    });
    emit(PlacesLoaded(places: allPlaces));
  }
}
