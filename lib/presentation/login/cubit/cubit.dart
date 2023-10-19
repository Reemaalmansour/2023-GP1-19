import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:novoy/presentation/login/cubit/state.dart';
import '../../../resources/routes_maneger.dart';
import '../../../shared/component/component.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../model/user_model.dart';
import '../login_screen.dart';

String? userName;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController resetPasswordController = TextEditingController();

  String gender = "";
  String emailError = "";
  String passwordError = "";

  void userRegister({
    @required String? name,
    @required String? email,
    @required String? phone,
    @required String? password,
    @required String? gender,
    @required String? age,
  }) async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: FirebaseAuth.instance.currentUser!.uid,
          gender: gender,
          age: age);
      emit(AuthRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      print("@@@@@@@@@@${e.code}");
      switch (e.code) {
        case 'email-already-in-use':
        // The user does not exist.
          emailError = 'The user does not exist.';
          print("The user does not exist.${e.code}");
          emit(EmailError(error: e.toString()));
          break;
        case 'wrong-password':
        // The password is incorrect.
          passwordError = 'The password is incorrect.';
          print("The password is incorrect.$e");
          emit(PasswordError(error: e.toString()));
          break;
        default:
        // An unknown error occurred.
          emailError = 'An unknown error occurred.';
          print("An unknown error occurred.$e");
          emit(AuthErrorOccurred(error: e.toString()));
      }
    }
  }

  void userCreate({
    @required String? name,
    @required String? email,
    @required String? phone,
    @required String? uId,
    @required String? gender,
    @required String? age,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      gender: gender,
      age: age,
    );

    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(model.toMap())
        .then((value) {})
        .catchError((error) {
      print("fireStore error ${error.toString()}");
      emit(AuthErrorOccurred(error: error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      bool saveUId = await CacheHelper.saveData(
          key: "uId", value: FirebaseAuth.instance.currentUser!.uid);
      if (saveUId == true) {
        uId = FirebaseAuth.instance.currentUser!.uid;
      }
      emit(UserLoginSuccess());
    } on FirebaseAuthException catch (e) {
      print("@@@@@@@@@@${e.code}");
      switch (e.code) {
        case 'INVALID_LOGIN_CREDENTIALS':
          // The user does not exist.
          emailError = 'The user does not exist.';
          print("The user does not exist.${e.code}");
          emit(EmailError(error: e.toString()));
          break;
        case 'wrong-password':
          // The password is incorrect.
          passwordError = 'The password is incorrect.';
          print("The password is incorrect.$e");
          emit(PasswordError(error: e.toString()));
          break;
        default:
          // An unknown error occurred.
          emailError = 'An unknown error occurred.';
          print("An unknown error occurred.$e");
          emit(AuthErrorOccurred(error: e.toString()));
      }
    }
  }

  bool passwordState = true;

  changePasswordState() {
    passwordState = !passwordState;
    emit(PasswordStateChanged());
  }

  void logOut(BuildContext context) async {
    try {
      var x = await CacheHelper.removeData(key: 'uId');

      if (x == true) {
        uId = "";
        await FirebaseAuth.instance.signOut();
        Phoenix.rebirth(context);
      }
      emit(LogOut());
    } catch (error) {
      print(error);
    }
  }
}
