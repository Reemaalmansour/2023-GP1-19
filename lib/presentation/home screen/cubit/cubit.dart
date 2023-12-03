import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/model/place_model.dart';
import 'package:novoy/model/triplocation_model.dart';
import 'package:novoy/presentation/favorite/favorite_screen.dart';
import 'package:novoy/presentation/home%20screen/cubit/state.dart';
import 'package:novoy/presentation/profile/profile_screen.dart';
import 'package:novoy/presentation/trip_screen/trip_screen.dart';

import '../../../global/global.dart';
import '../../../model/category_model.dart';
import '../../../model/trip_model.dart';
import '../../../model/user_model.dart';
import '../../../resources/assets_maneger.dart';
import '../home_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  TextEditingController homeSearchController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();
  TextEditingController tripNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String? uId = FirebaseAuth.instance.currentUser?.uid;

  List<CategoryModel> categories = [
    CategoryModel(
      cId: "1",
      name: 'Hotels',
      image: AppAssets.hotelCat,
      description: "description",
    ),
    CategoryModel(
      cId: "1",
      name: 'Places',
      image: AppAssets.placesCat,
      description: "description",
    ),
    CategoryModel(
      cId: "1",
      name: 'Restaurants',
      image: AppAssets.restaurantsCat,
      description: "description",
    ),
  ];

  List<PlaceModel> favList = [];

  int currentIndex = 0;

  String endLocationDescription = "";
  String startLocationDescription = "";

  bool isEditing = false;

  changeIsEditing() {
    isEditing = !isEditing;
    emit(NavigationBarChanged());
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.note_alt_outlined),
      label: "Trips",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const TripScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNavBar(context, index) {
    currentIndex = index;
    emit(NavigationBarChanged());
  }

  UserModel? userData;

  Future<void> getUserData() async {
    uId = await FirebaseAuth.instance.currentUser?.uid;
    log('+++++++++++++${uId}++++++++++++++++');
    if (uId == null || uId!.isEmpty) return;
    print("+++++++++++++++++++++++++${uId}");
    try {
      var response =
          await FirebaseFirestore.instance.collection('user').doc(uId).get();
      log('++++++++++++response ${response.data()}+++++++++++++++++');
      log(response.toString());
      userData = UserModel.fromJson(response.data()!);
      log('+++++++++++++++++++++++++++++');
      kUser = userData;
      log('+++++++++++++kUser $kUser ++++++++++++++++');
      emit(UserDataSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(ErrorOccurred(error: e.toString()));
      throw e;
    }
  }

  Future updateUserData({
    required String userName,
    required String email,
    required String phone,
  }) async {
    print("+++++++++++++++++++++++++${FirebaseAuth.instance.currentUser!.uid}");
    try {
      if (userName.isEmpty && email.isEmpty && phone.isEmpty) return;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        if (userName.isNotEmpty) "username": userName,
        if (email.isNotEmpty) "email": email,
        if (phone.isNotEmpty) "phone": phone,
      });

      log('+++++++++++++++++++++++++++++');
      emit(UpdateDataSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    // Get the user's document reference from the `users` collection.
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Delete the user's document from the `users` collection.
    await userDocRef.delete();

    // Delete the user's account from Firebase Authentication.
    await FirebaseAuth.instance.currentUser!.delete();
    emit(DeleteUserSuccess());
    // Return a success message.
  }

  List<TripModel>? tripModel = [];
  List<TripLocation> locations = [];

  // Future getTripData() async {
  //   tripModel = [];
  //   emit(TripLoading());
  //   try {
  //     var response = await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(uId)
  //         .collection("trip")
  //         .get();
  //     response.docs.forEach((element) {
  //       log(element.data().toString());
  //       tripModel!.add(TripModel.fromJson(element.data()));
  //     });
  //     emit(TripSuccess());
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     emit(ErrorOccurred(error: e.toString()));
  //   }
  // }

  // createPlan({
  //   required String name,
  //   required String destination,
  //   required String startdate,
  //   required String enddate,
  // }) async {
  //   print(
  //       "***startdestination******$destination**********startdate***************$startdate*****enddate*******$enddate*****");
  //   TripModel model = TripModel(
  //     name: name,
  //     destination: destination,
  //     startdate: startdate,
  //     enddate: enddate,
  //   );

  //   try {
  //     DocumentReference tripReference = await FirebaseFirestore.instance
  //         .collection("user")
  //         .doc(uId)
  //         .collection("trip")
  //         .add(model.toJson());

  //     String tripId = tripReference.id;

  //     print("*********** tripId: $tripId *************");

  //     // Clear controllers or perform other actions
  //     startdateController.clear();
  //     enddateController.clear();
  //     tripNameController.clear();

  //     emit(CreatePlanSuccess());
  //   } catch (error) {
  //     print("fireStore error ${error.toString()}");
  //     emit(ErrorOccurred(error: error.toString()));
  //   }
  // }

  addLocationToDate({
    required String tripName,
    required String placeName,
    required String time,
    required String date,
  }) async {
    try {
      // Query to retrieve the trip document based on the trip name
      QuerySnapshot tripQuery = await FirebaseFirestore.instance
          .collection("user")
          .doc(uId)
          .collection("trip")
          .where("name", isEqualTo: tripName)
          .get();

      if (tripQuery.docs.isNotEmpty) {
        // Get the first document in the query result
        var tripDocument = tripQuery.docs.first;
        String tripId = tripDocument.id;

        // Create the TripLocation model
        TripLocation locationModel = TripLocation(
          name: placeName,
          time: time,
        );

        // Add the location to the specified date within the trip
        await FirebaseFirestore.instance
            .collection("user")
            .doc(uId)
            .collection("trip")
            .doc(tripId)
            .collection(
              "locations",
            ) // Create a subcollection for locations within each trip
            .doc(
              date,
            ) // Use the date as the document ID within the "locations" subcollection
            .collection(
              "places",
            ) // Create a subcollection for places within each date
            .add(locationModel.toJson());

        print("Location added successfully for tripId: $tripId, date: $date");
      } else {
        print("Trip not found for name: $tripName");
        // Handle the case where the trip is not found based on the provided name
        emit(ErrorOccurred(error: "Trip not found for name: $tripName"));
      }
    } catch (error) {
      print("fireStore error ${error.toString()}");
      emit(ErrorOccurred(error: error.toString()));
    }
  }

  Future<String?> getTripIdByName({
    required String tripName,
  }) async {
    try {
      // Query to retrieve the trip document based on the trip name
      QuerySnapshot tripQuery = await FirebaseFirestore.instance
          .collection("user")
          .doc(uId)
          .collection("trip")
          .where("name", isEqualTo: tripName)
          .get();

      if (tripQuery.docs.isNotEmpty) {
        // Get the first document in the query result
        var tripDocument = tripQuery.docs.first;
        return tripDocument.id;
      } else {
        print("Trip not found for name: $tripName");
        return null; // Return null if the trip is not found
      }
    } catch (error) {
      print("Firestore error ${error.toString()}");
      return null; // Return null in case of an error
    }
  }

  Future<List<TripLocation>> getLocationsByDate({
    required String tripName,
    required String date,
  }) async {
    try {
      // Get the tripId using the getTripIdByName function
      String? tripId = await getTripIdByName(tripName: tripName);

      if (tripId != null) {
        // Query to retrieve all location documents for the specified date
        var locationQuery = await FirebaseFirestore.instance
            .collection("user")
            .doc(uId)
            .collection("trip")
            .doc(tripId)
            .collection("locations")
            .doc(date)
            .collection("places")
            .get();

        // Iterate through each location document and parse the data
        locations = locationQuery.docs
            .map(
              (locationDocument) =>
                  TripLocation.fromJson(locationDocument.data()),
            )
            .toList();
      } else {
        // Handle the case where the trip is not found based on the provided name
        emit(ErrorOccurred(error: "Trip not found for name: $tripName"));
      }
    } catch (error) {
      print("Firestore error ${error.toString()}");
      emit(ErrorOccurred(error: error.toString()));
    }

    return locations;
  }

  void deleteTrip(String tripName) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .collection("trip")
        .where("name", isEqualTo: tripName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete().then((value) {
          print("*****deleteTrip*********  SuccessFull  *************");
        }).catchError((error) {
          print("fireStore error ${error.toString()}");
          emit(ErrorOccurred(error: error.toString()));
        });
      });
    }).catchError((error) {
      print("fireStore error ${error.toString()}");
      emit(ErrorOccurred(error: error.toString()));
    });
  }
}
