import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:novoy/shared/component/component.dart';

import '../../../model/user_model.dart';
import '../../login/login_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userData;
  String gender = "";

  Future getUserData() async {
    if (uId.isEmpty) return;
    print("+++++++++++++++++++++++++${uId}");
    try {
      var response =
          await FirebaseFirestore.instance.collection('user').doc(uId).get();
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
    required String userName,
    required String email,
    required String phone,
    required String age,
  }) async {
    print("+++++++++++++++++++++++++${FirebaseAuth.instance.currentUser!.uid}");
    try {
      if (userName.isEmpty && email.isEmpty && phone.isEmpty) return;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        if (userName.isNotEmpty) "name": userName,
        if (email.isNotEmpty) "email": email,
        if (phone.isNotEmpty) "phone": phone,
        if (age.isNotEmpty) "age": age,
      });

      showToast(msg: "Edit profile Success", state: ToastStates.SUCCESS);

      log('+++++++++++++++++++++++++++++');
      emit(UpdateDataSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(ProfileErrorOccurred(error: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    // Get the user's document reference from the `users` collection.
    final userDocRef = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Delete the user's document from the `users` collection.
    await userDocRef.delete();

    // Delete the user's account from Firebase Authentication.
    await FirebaseAuth.instance.currentUser!.delete();
    emit(DeleteUserSuccess());
    // Return a success message.
  }
}
