import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../../../model/user/user_model.dart';
import '../../../resources/constant_maneger.dart';
import '/global/global.dart';
import '/shared/component/component.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  String? uId = FirebaseAuth.instance.currentUser?.uid;

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userData;
  String gender = "";

  Future getUserData() async {
    if (uId == null || uId!.isEmpty) return;
    print("+++++++++++++++++++++++++${uId}");
    try {
      var response = await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(uId)
          .get();
      log('+++++++++++++++++++++++++++++');
      log(response.toString());
      userData = UserModel.fromJson(response.data()!);
      log('+++++++++++++++++++++++++++++');
      emit(UserDataSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(ProfileErrorOccurred(error: e.toString()));
      throw e;
    }
  }

  Future updateUserData({
    required String name,
    required String email,
    required String phone,
    required String age,
    required String gender,
    required File? image,
  }) async {
    try {
      showToast(msg: "Edit profile Success", state: ToastStates.SUCCESS);
      String? imageUrl;
      if (image != null) {
        imageUrl = await Utils.uploadProfileImage(
          image: image,
        );
      }

      UserModel updatedUser = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        gender: gender,
        age: age,
        tripsIds: kUser?.tripsIds ?? [],
        sharedTripsIds: kUser?.sharedTripsIds ?? [],
        favPlacesIds: kUser?.favPlacesIds ?? [],
        listOfInterestsTypes: kUser?.listOfInterestsTypes ?? [],
        favPlaces: kUser?.favPlaces ?? [],
        imageUrl: imageUrl,
        password: kUser?.password ?? "",
      );
      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(uId)
          .update(updatedUser.toJson());

      log('+++++++++++++++++++++++++++++');
      emit(UpdateDataSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(ProfileErrorOccurred(error: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    // Get the user's document reference from the `users` collection.
    uId = await FirebaseAuth.instance.currentUser!.uid;
    if (uId != null) {
      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(uId)
          .delete()
          .then(
            (value) async => await FirebaseAuth.instance.currentUser!.delete(),
          );
    }

    emit(DeleteUserSuccess());
    // Return a success message.
  }
}
