import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  sendResetPassword() {
    print(AuthCubit.get(context).resetPasswordController.text);
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(
          email: AuthCubit.get(context).resetPasswordController.text);
    } on FirebaseAuthException catch (e) {
      print("@@@@@@@@@@${e.code}");
      switch (e.code) {
        case 'The user does not exist.':
          // The user does not exist.
          AuthCubit.get(context).emailError = 'The user does not exist.';
          print("The user does not exist.${e.code}");
          break;
        default:
          // An unknown error occurred.
          AuthCubit.get(context).emailError = 'An unknown error occurred.';
          print("An unknown error occurred.$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Reset your Password"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: responsive.sHeight(context),
              child: ListView(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Enter your email to receive an email to reset your password",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ColorManager.primary, fontSize: 18),
                  ),
                  SizedBox(
                    height: responsive.sHeight(context) * .15,
                  ),
                  responsive.sizedBoxH10,
                  Center(
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password cant empty";
                        }
                        if (val.length > 50) {
                          return "password cant be more than 50 letter";
                        }
                        if (val.length < 8) {
                          return "password cant be less than 8 letter";
                        }
                        return null;
                      },
                      controller:
                          AuthCubit.get(context).resetPasswordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "E-mail Address",
                      ),
                    ),
                  ),
                  responsive.sizedBoxH30,
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text("Reset"),
                        onPressed: () {
                          if (formState.currentState!.validate()) {
                            sendResetPassword();
                            navigateTo(context, Routes.resetPasswordLinkSend);
                          }
                        },
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
