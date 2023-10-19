import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/presentation/favorite/favorite_screen.dart';

import 'package:novoy/presentation/home%20screen/cubit/state.dart';
import 'package:novoy/presentation/profile/profile_screen.dart';
import 'package:novoy/presentation/trip_screen/trip_screen.dart';

import '../../../model/user_model.dart';
import '../../login/login_screen.dart';
import '../home_screen.dart';
import '../../login/cubit/cubit.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  TextEditingController homeSearchController = TextEditingController();
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorite"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.note_alt_outlined), label: "Trips"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];
  List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    TripScreen(),
    ProfileScreen(),
  ];


  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(NavigationBarChanged());
  }

  UserModel? userData;

  Future getUserData() async {
    if (uId.isEmpty) return;
    print("+++++++++++++++++++++++++${uId}");
    try {
      var response = await FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .get();
      log('+++++++++++++++++++++++++++++');
      log(response.toString());
      userData = UserModel.fromJson(response.data()!);
      log('+++++++++++++++++++++++++++++');
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
}
