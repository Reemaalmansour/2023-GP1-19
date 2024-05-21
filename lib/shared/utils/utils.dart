import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/global.dart';
import '../../model/place/n_place_model.dart';
import '../../model/place/place_model.dart';
import '../../model/trip/trip_model.dart';
import '../../model/trip_destination/trip_destination_model.dart';
import '../../presentation/places details/places_details.dart';
import '../../resources/constant_maneger.dart';
import '/model/review_result/review_result.dart';
import '/model/trip_place/trip_place_model.dart';

class Utils {
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24 && dateTime.day == now.day) {
      return '${difference.inHours} hours ago';
    } else if (dateTime.day == now.day - 1 && dateTime.month == now.month) {
      return 'Yesterday at ${DateFormat.jm().format(dateTime)}';
    } else if (dateTime.year == now.year && dateTime.month == now.month) {
      return '${DateFormat.MMMd().format(dateTime)} at ${DateFormat.jm().format(dateTime)}';
    } else {
      return '${DateFormat.yMMMd().format(dateTime)} at ${DateFormat.jm().format(dateTime)}';
    }
  }

  // uploadImages
  static Future<List<String>> uploadImages({
    required List<File> images,
  }) async {
    List<String> imageUrls = [];
    try {
      for (var image in images) {
        final ref = await FirebaseStorage.instance
            .ref()
            .child('places_images')
            .child('${DateTime.now().toIso8601String()}');
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
    } catch (e) {
      log("uploadImages error ${e.toString()}");
    } finally {
      return imageUrls;
    }
  }

  // upload profile image
  static Future<String> uploadProfileImage({
    required File image,
  }) async {
    String imageUrl = "";
    try {
      final ref = await FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().toIso8601String()}');
      await ref.putFile(image);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      log("uploadProfileImage error ${e.toString()}");
    } finally {
      return imageUrl;
    }
  }

  // pick image
  static Future<File?> pickImage({
    required ImageSource source,
  }) async {
    File? image;
    try {
      // pick image
      final xImage = await ImagePicker().pickImage(source: source);
      if (xImage != null) {
        image = File(xImage.path);
      }
    } catch (e) {
      log("pickImage error ${e.toString()}");
    } finally {
      return image;
    }
  }

  // pick multiple images
  static Future<List<File>> pickMultipleImages() async {
    List<File> images = [];
    try {
      // pick multiple images
      final xImage = await ImagePicker().pickMultiImage();
      for (var i in xImage) {
        final image = File(i.path);
        images.add(image);
      }
    } catch (e) {
      log("pickMultipleImages error ${e.toString()}");
    } finally {
      return images;
    }
  }

  static int decodePriceLevel(String priceLevel) {
    switch (priceLevel) {
      case "free":
        return 0;
      case "inexpensive":
        return 1;
      case "moderate":
        return 2;
      case "expensive":
        return 3;
      case "very expensive":
        return 4;
      default:
        return 0;
    }
  }

  static int decodePriceLevelFromEnum(PriceLevel priceLevel) {
    switch (priceLevel) {
      case PriceLevel.free:
        return 0;
      case PriceLevel.inexpensive:
        return 1;
      case PriceLevel.moderate:
        return 2;
      case PriceLevel.expensive:
        return 3;
      case PriceLevel.veryExpensive:
        return 4;
      default:
        return 0;
    }
  }

  // decode price level
  static String encodePriceLevel(int priceLevel) {
    switch (priceLevel) {
      case 0:
        return "free";
      case 1:
        return "inexpensive";
      case 2:
        return "moderate";
      case 3:
        return "expensive";
      case 4:
        return "very expensive";
      default:
        return "free";
    }
  }

  static Future<String> getPhoto(String photoRef) async {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=${AppConstant.apiKey}';
  }

  static Future<void> searchForPlaceDetails({
    required BuildContext context,
  }) async {
    try {
      var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: AppConstant.apiKey,
        mode: Mode.fullscreen,
        language: "ar",
        strictbounds: false,
        components: [
          Component(Component.country, "sa"),
        ],
        types: [
          "restaurant",
          "cafe",
          "park",
        ],
        onError: (err) {
          log("fetchPlacesDetails error ${err.toString()} ");
        },
      );
      if (place == null) return;
      context.loaderOverlay.show();
      final plist = GoogleMapsPlaces(
        apiKey: AppConstant.apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      String placeid = place.placeId ?? "0";
      PlacesDetailsResponse detail = await plist.getDetailsByPlaceId(
        placeid,
      );

      List<String> photos = [];

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
        isFav: false,
        types: detail.result.types,
      );
      final newDetails = await fetchPlaceDetails(newPlace.pId!);
      final updatedPlace = newPlace.copyWith(
        reviewsResult: ReviewResult.fromJson(newDetails["result"]),
      );
      context.loaderOverlay.hide();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlacesDetails(
            place: updatedPlace,
            isAdd: false,
          ),
        ),
      );
    } catch (e) {
      log("fetchPlacesDetails error ${e}");
    } finally {
      log("fetchPlacesDetails finally");
    }
  }

  static Future<PlaceModel?> searchForPlace({
    required BuildContext context,
  }) async {
    try {
      var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: AppConstant.apiKey,
        mode: Mode.fullscreen,
        language: "ar",
        strictbounds: false,
        components: [
          Component(Component.country, "sa"),
        ],
        types: [
          "restaurant",
          "cafe",
          "park",
        ],
        onError: (err) {
          log("fetchPlacesDetails error ${err.toString()} ");
        },
      );
      if (place == null) return null;
      context.loaderOverlay.show();
      final plist = GoogleMapsPlaces(
        apiKey: AppConstant.apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      String placeid = place.placeId ?? "0";
      PlacesDetailsResponse detail = await plist.getDetailsByPlaceId(
        placeid,
      );

      List<String> photos = [];

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
        isFav: false,
        types: detail.result.types,
      );
      final newDetails = await fetchPlaceDetails(newPlace.pId!);
      final updatedPlace = newPlace.copyWith(
        reviewsResult: ReviewResult.fromJson(newDetails["result"]),
      );
      context.loaderOverlay.hide();
      return updatedPlace;
    } catch (e) {
      log("fetchPlacesDetails error ${e}");
    } finally {
      log("fetchPlacesDetails finally");
    }
    return null;
  }

  static Future<dynamic> fetchPlaceDetails(String pId) async {
    var placeDetails;
    try {
      // fetch place details from google places api
      final String url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$pId&fields=name,rating,reviews&key=${AppConstant.apiKey}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        placeDetails = json.decode(response.body);
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      log("fetchPlaceDetails error ${e}");
    } finally {
      log("fetchPlaceDetails finally");
      return placeDetails;
    }
  }

  // open google maps with lat and long
  static Future<void> openGoogleMaps({
    required double lat,
    required double long,
  }) async {
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
    // convert googleUrl to apple URI scheme

    // apple maps
    // Uri appleUrl = Uri.parse(
    //   'https://maps.apple.com/?sll=$lat,$long&z=10&t=s&dirflg=d&showlabs=1',
    // );
    if (Platform.isIOS) {
      // for iOS phone
      if (await canLaunchUrl(googleUrl)) {
        await launchUrl(googleUrl).onError(
          (error, stackTrace) {
            log(error.toString());
            throw 'Could not open the map.';
          },
        );
      } else {
        throw 'Could not open the map.';
      }
    } else {
      // for Android phone
      if (await canLaunchUrl(googleUrl)) {
        await launchUrl(googleUrl).onError((error, stackTrace) {
          log(error.toString());
          throw 'Could not open the map.';
        });
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  static Future<List<PlaceModel>> fetchPlaces() async {
    final places = <PlaceModel>[];
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
      }
    } catch (e) {
      log(e.toString());
    } finally {
      return places;
    }
  }

  static Future<void> fetchMyTrips() async {
    try {
      List<TripModel> trips = [];
      for (var i in kUser!.tripsIds!) {
        await FirebaseFirestore.instance
            .collection(AppConstant.tripsCollection)
            .doc(i)
            .get()
            .then((value) async {
          if (value.exists) {
            final trip = TripModel.fromJson(value.data()!);
            trip.destinations = [];
            for (var i in trip.destinationsIds!) {
              await FirebaseFirestore.instance
                  .collection(AppConstant.destinationsCollection)
                  .doc(i)
                  .get()
                  .then((value) {
                if (value.exists) {
                  final destination =
                      TripDestinationModel.fromJson(value.data()!);
                  trip.destinations!.add(destination);
                } else {
                  log("destination not found");
                }
              });
            }
            trips.add(trip);
          }
        });
      }
      // sort trips by date
      trips.sort((a, b) => a.createOn!.compareTo(b.createOn!));
      Global.kTrips = trips;
    } catch (error) {
      log("error from _onLoadTrips ${error.toString()}");
    }
  }

  static Future<bool> addNewTrip({
    required TripModel trip,
  }) async {
    bool isAdded = false;
    List<TripModel> allTrips = Global.kTrips;
    try {
      String destinationId = trip.destinations!.first.destinationId!;
      TripDestinationModel destination = trip.destinations!.first;

      await FirebaseFirestore.instance
          .collection(AppConstant.destinationsCollection)
          .doc(destinationId)
          .set(destination.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstant.tripsCollection)
          .doc(trip.tripId)
          .set(trip.toJson());

      kUser!.tripsIds!.add(trip.tripId!);

      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(kUser!.uId)
          .update(kUser!.toJson());

      allTrips.add(trip);
      Global.kTrips = allTrips;
      isAdded = true;
    } catch (e) {
      log("error from _onAddTrip ${e.toString()}");
      isAdded = false;
    } finally {
      return isAdded;
    }
  }

  static Future<bool> onAddVisitedPlaceToTripDestination({
    required TripDestinationModel destination,
    required TripPlaceModel visitedPlace,
  }) async {
    List<TripModel> allTrips = Global.kTrips;

    bool isAdded = false;
    try {
      log('destination ${destination.destinationId}');
      await FirebaseFirestore.instance
          .collection(AppConstant.destinationsCollection)
          .doc(destination.destinationId)
          .update({
        "visitedPlaces": FieldValue.arrayUnion([
          visitedPlace.toJson(),
        ]),
      });

      destination.visitedPlaces?.add(visitedPlace);
      List<TripDestinationModel> updatedDestinations = List.from(
        allTrips
            .firstWhere((element) => element.tripId == destination.tripId)
            .destinations!,
      );
      updatedDestinations.remove(destination);
      updatedDestinations.add(destination);
      TripModel updatedTrip = allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .copyWith(destinations: updatedDestinations);

      allTrips.removeWhere((element) => element.tripId == destination.tripId);
      allTrips.add(updatedTrip);
      Global.kTrips = allTrips;
      isAdded = true;
    } catch (e) {
      log("error from _onAddVisitedPlaceToTripDestination ${e.toString()}");
      isAdded = false;
    } finally {
      return isAdded;
    }
  }

  static Future<void> onUpdateVisitedPlaceToTripDestination({
    required TripDestinationModel destination,
    required TripPlaceModel visitedPlace,
  }) async {
    log("destination ${destination.destinationId}");
    List<TripModel> allTrips = Global.kTrips;

    try {
      destination.visitedPlaces?.removeWhere((element) {
        return element.pId == visitedPlace.pId;
      });
      destination.visitedPlaces?.add(visitedPlace);

      await FirebaseFirestore.instance
          .collection(AppConstant.destinationsCollection)
          .doc(destination.destinationId)
          .update({
        "visitedPlaces":
            destination.visitedPlaces?.map((e) => e.toJson()).toList(),
      });
      List<TripDestinationModel> updatedDestinations = List.from(
        allTrips
            .firstWhere((element) => element.tripId == destination.tripId)
            .destinations!,
      );
      updatedDestinations.removeWhere(
        (element) => element.destinationId == destination.destinationId,
      );
      updatedDestinations.add(destination);

      TripModel updatedTrip = allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .copyWith(destinations: updatedDestinations);

      allTrips.removeWhere((element) => element.tripId == destination.tripId);
      allTrips.add(updatedTrip);
      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onUpdateVisitedPlaceToTripDestination ${e.toString()}");
    }
  }

  // static Future<void> onRemoveVisitedPlaceFromTripDestination({
  //   required TripDestinationModel destination,
  //   required TripPlaceModel place,
  // }) async {
  //   List<TripModel> allTrips = Global.kTrips;
  //   try {
  //     TripDestinationModel uDestination = destination.copyWith(
  //       visitedPlaces: destination.visitedPlaces!..remove(place),
  //     );

  //     List<TripDestinationModel> listDestinations = List.from(
  //       allTrips
  //           .firstWhere((element) => element.tripId == destination.tripId)
  //           .destinations!,
  //     );
  //     listDestinations.remove(destination);
  //     listDestinations.add(uDestination);

  //     TripModel updatedTrip = allTrips
  //         .firstWhere((element) => element.tripId == destination.tripId)
  //         .copyWith(destinations: listDestinations);

  //     allTrips.removeWhere((element) => element.tripId == destination.tripId);
  //     allTrips.add(updatedTrip);

  //     await FirebaseFirestore.instance
  //         .collection(AppConstant.destinationsCollection)
  //         .doc(uDestination.destinationId)
  //         .update({
  //       "visitedPlaces":
  //           uDestination.visitedPlaces?.map((e) => e.toJson()).toList(),
  //     });

  //     Global.kTrips = allTrips;
  //   } catch (e) {
  //     log("error from _onRemoveVisitedPlaceFromTripDestination ${e.toString()}");
  //   }
  // }
  static Future<void> onRemoveVisitedPlaceFromTripDestination({
    required TripDestinationModel destination,
    required TripPlaceModel place,
  }) async {
    List<TripModel> allTrips = Global.kTrips;

    try {
      TripDestinationModel uDestination =
          _updateDestination(destination, place);
      List<TripDestinationModel> updatedDestinations =
          _updateDestinations(allTrips, destination, uDestination);
      TripModel updatedTrip =
          _updateTrip(allTrips, destination, updatedDestinations);

      await _updateFirestoreDestination(uDestination);

      Global.kTrips = _updateGlobalTrips(allTrips, updatedTrip);
    } catch (e) {
      log("error from _onRemoveVisitedPlaceFromTripDestination ${e.toString()}");
    }
  }

  static TripDestinationModel _updateDestination(
    TripDestinationModel destination,
    TripPlaceModel place,
  ) {
    return destination.copyWith(
      visitedPlaces: destination.visitedPlaces!..remove(place),
    );
  }

  static List<TripDestinationModel> _updateDestinations(
    List<TripModel> allTrips,
    TripDestinationModel destination,
    TripDestinationModel uDestination,
  ) {
    List<TripDestinationModel> listDestinations = List.from(
      allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .destinations!,
    );

    listDestinations.remove(destination);
    listDestinations.add(uDestination);

    return listDestinations;
  }

  static TripModel _updateTrip(
    List<TripModel> allTrips,
    TripDestinationModel destination,
    List<TripDestinationModel> updatedDestinations,
  ) {
    TripModel updatedTrip = allTrips
        .firstWhere((element) => element.tripId == destination.tripId)
        .copyWith(destinations: updatedDestinations);

    return updatedTrip;
  }

  static Future<void> _updateFirestoreDestination(
    TripDestinationModel uDestination,
  ) async {
    await FirebaseFirestore.instance
        .collection(AppConstant.destinationsCollection)
        .doc(uDestination.destinationId)
        .update({
      "visitedPlaces":
          uDestination.visitedPlaces?.map((e) => e.toJson()).toList(),
    });
  }

  static List<TripModel> _updateGlobalTrips(
    List<TripModel> allTrips,
    TripModel updatedTrip,
  ) {
    allTrips.removeWhere((element) => element.tripId == updatedTrip.tripId);
    allTrips.add(updatedTrip);

    return allTrips;
  }

  static Future<void> onDeleteDestination({
    required TripModel trip,
    required TripDestinationModel destination,
  }) async {
    List<TripModel> allTrips = Global.kTrips;
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.destinationsCollection)
          .doc(destination.destinationId)
          .delete();

      trip.destinationsIds!.remove(destination.destinationId);

      await FirebaseFirestore.instance
          .collection(AppConstant.tripsCollection)
          .doc(trip.tripId)
          .update({
        "destinationsIds": trip.destinationsIds,
      });

      allTrips
          .firstWhere((element) => element.tripId == trip.tripId)
          .destinations
          ?.remove(destination);
      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onDeleteDestination ${e.toString()}");
    }
  }

  static Future<void> onAddDestinationToTheTrip({
    required TripModel trip,
    required TripDestinationModel destination,
  }) async {
    List<TripModel> allTrips = Global.kTrips;

    try {
      await _addDestinationToFirestore(destination);

      List<String> updatedDestinationsIds =
          _updateTripDestinationsIds(trip, destination.destinationId!);
      await _updateTripDestinationsIdsInFirestore(trip, updatedDestinationsIds);

      TripModel updatedTrip =
          _updateTripDestinations(allTrips, trip, destination);
      Global.kTrips = _updateGlobalTrips(allTrips, updatedTrip);
    } catch (e) {
      log("error from _onAddDestinationToTheTrip ${e.toString()}");
    }
  }

  static Future<void> _addDestinationToFirestore(
    TripDestinationModel destination,
  ) async {
    await FirebaseFirestore.instance
        .collection(AppConstant.destinationsCollection)
        .doc(destination.destinationId)
        .set(destination.toJson());
  }

  static List<String> _updateTripDestinationsIds(
    TripModel trip,
    String destinationId,
  ) {
    List<String> updatedDestinationsIds = List.from(trip.destinationsIds!);

    // Check if the destinationId already exists in the list before adding
    if (!updatedDestinationsIds.contains(destinationId)) {
      updatedDestinationsIds.add(destinationId);
    }

    return updatedDestinationsIds;
  }

  static Future<void> _updateTripDestinationsIdsInFirestore(
    TripModel trip,
    List<String> updatedDestinationsIds,
  ) async {
    await FirebaseFirestore.instance
        .collection(AppConstant.tripsCollection)
        .doc(trip.tripId)
        .update({
      "destinationsIds": updatedDestinationsIds,
    });
  }

  static TripModel _updateTripDestinations(
    List<TripModel> allTrips,
    TripModel trip,
    TripDestinationModel destination,
  ) {
    TripModel updatedTrip = allTrips
        .firstWhere((element) => element.tripId == trip.tripId)
        .copyWith(destinations: [...?trip.destinations, destination]);

    // check if the destination already exists in the list before adding
    if (updatedTrip.destinations!.contains(destination)) {
      updatedTrip.destinations!.remove(destination);
    }

    return updatedTrip;
  }

  static Future<void> onUpdateDestinationToTheTrip({
    required TripModel trip,
    required TripDestinationModel destination,
  }) async {
    List<TripModel> allTrips = Global.kTrips;
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.destinationsCollection)
          .doc(destination.destinationId)
          .update(destination.toJson());

      List<TripDestinationModel> updatedDestinations = List.from(
        allTrips
            .firstWhere((element) => element.tripId == destination.tripId)
            .destinations!,
      );
      updatedDestinations.remove(destination);
      updatedDestinations.add(destination);
      TripModel updatedTrip = allTrips
          .firstWhere((element) => element.tripId == destination.tripId)
          .copyWith(destinations: updatedDestinations);

      allTrips.removeWhere((element) => element.tripId == destination.tripId);
      allTrips.add(updatedTrip);
      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onUpdateDestinationToTheTrip ${e.toString()}");
    }
  }

  // load sheared trips with me
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
  static Future<void> fetchSharedTrips() async {
    try {
      List<TripModel> trips = [];
      for (var i in kUser!.sharedTripsIds!) {
        await FirebaseFirestore.instance
            .collection(AppConstant.tripsCollection)
            .doc(i)
            .get()
            .then((value) async {
          if (value.exists) {
            final trip = TripModel.fromJson(value.data()!);
            trip.destinations = [];
            for (var i in trip.destinationsIds!) {
              await FirebaseFirestore.instance
                  .collection(AppConstant.destinationsCollection)
                  .doc(i)
                  .get()
                  .then((value) {
                if (value.exists) {
                  final destination =
                      TripDestinationModel.fromJson(value.data()!);
                  trip.destinations!.add(destination);
                } else {
                  log("destination not found");
                }
              });
            }
            trips.add(trip);
          }
        });
      }
      // sort trips by date
      trips.sort((a, b) => a.createOn!.compareTo(b.createOn!));
      Global.kSharedTrips = trips;
    } catch (error) {
      log("error from _onLoadTrips ${error.toString()}");
    }
  }

  // onDelete trip
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
  static Future<void> onDeleteTrip({
    required TripModel trip,
  }) async {
    List<TripModel> allTrips = Global.kTrips;
    try {
      //delete all destinations
      for (var i in trip.destinationsIds!) {
        await FirebaseFirestore.instance
            .collection(AppConstant.destinationsCollection)
            .doc(i)
            .delete();
      }
      //delete trip
      await FirebaseFirestore.instance
          .collection(AppConstant.tripsCollection)
          .doc(trip.tripId)
          .delete();
      //delete trip from user
      kUser?.tripsIds?.remove(trip.tripId);
      // update user in firestore
      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(kUser!.uId)
          .update({
        "tripsIds": kUser!.tripsIds,
      });
      // update all trips
      allTrips.remove(trip);
      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onDeleteTrip ${e.toString()}");
    }
  }

  // on update trip destination

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
  static Future<void> onUpdateTrip({
    required TripModel updatedTrip,
  }) async {
    List<TripModel> allTrips = Global.kTrips;
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.tripsCollection)
          .doc(updatedTrip.tripId)
          .update(
            updatedTrip.toJson(),
          );

      final selectedTrip = allTrips
          .firstWhere((element) => element.tripId == updatedTrip.tripId);
      final updateTrip = selectedTrip.copyWith(
        name: updatedTrip.name,
        destinations: List.from(updatedTrip.destinations ?? []),
        destinationsIds: List.from(updatedTrip.destinationsIds ?? []),
      );
      allTrips.remove(selectedTrip);
      allTrips.add(updateTrip);

      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onUpdateTrip ${e.toString()}");
    }
  }

  // on update trip destination
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
  static Future<void> onUpdateTripDestination({
    required TripModel trip,
  }) async {
    List<TripModel> allTrips = Global.kTrips;
    try {
      for (var i in trip.destinationsIds!) {
        await FirebaseFirestore.instance
            .collection(AppConstant.destinationsCollection)
            .doc(i)
            .get()
            .then((value) {
          if (value.exists) {
            final destination = TripDestinationModel.fromJson(value.data()!);

            trip.destinations?.add(destination);
          } else {
            log("destination not found");
          }
        });
      }
      allTrips
          .firstWhere((element) => element.tripId == trip.tripId)
          .destinations
          ?.clear();
      allTrips
          .firstWhere((element) => element.tripId == trip.tripId)
          .destinations
          ?.addAll(trip.destinations!);
      Global.kTrips = allTrips;
    } catch (e) {
      log("error from _onUpdateTripDestination ${e.toString()}");
    }
  }

  // add place to favPlaces list in user firestore

  static Future<void> onToggleFav() async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(kUser!.uId)
          .set(
        {
          "favPlaces": Global.favPlaces.map((e) => e.toJson()).toList(),
        },
        SetOptions(merge: true),
      ).then((value) {
        log("place added to favPlaces");
      });
    } catch (e) {
      log("error from _onAddPlaceToFavPlaces ${e.toString()}");
    }
  }

  // fetch recommended places
  static FutureOr<List<PlaceModel>> fetchServerRecommendedPlaces({
    required tripName,
    required userID,
  }) async {
    log("userID $userID, tripName $tripName");
    List<PlaceModel> places = [];
    try {
      final response = await http.get(
        Uri.parse(
          "https://dana222.pythonanywhere.com/recommended_places/$userID",
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // log("data $data");

        for (var item in data[tripName]["recommended_places"]) {
          NPlaceModel place = NPlaceModel.fromJson(item);
          PlaceModel updatedPalce = PlaceModel(
            pId: place.pId,
            name: place.name,
            lat: place.lat,
            lng: place.lng,
            address: place.address,
            description: place.description,
            image: place.image,
            imageUrls: place.imageUrls,
            isFav: false,
            types: place.types,
            reviewsResult: null,
            Type: place.types,
            rating: place.rating,
            priceLevel: place.priceLevel,
            VisitDate: place.VisitDate,
          );
          places.add(updatedPalce);
        }
      }
    } catch (e) {
      log("error from fetchServerPlaces ${e.toString()}");
    }
    return places;
  }
}
