import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

String uId = "";

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, state) {
              if (state is UserLoginSuccess) {
                navigateToAndReplacement(context, Routes.appLayout);
              }
              if (state is AuthErrorOccurred) {
                if (state.error.isNotEmpty) {
                  showToast(msg: "too many request", state: ToastStates.ERROR);
                }
              }
            },
            builder: (BuildContext context, state) => Form(
              key: formState,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: responsive.sHeight(context) * .2,
                          width: responsive.sWidth(context) * .4,
                          child: Image.asset(ImageAssets.logo),
                        ),
                      ),
                      responsive.sizedBoxH30,
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Login to plan your next trip!",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "e-mail cant empty";
                          }
                          if (val.length > 50) {
                            return "e-mail cant be more than 50 letter";
                          }
                          if (val.length < 2) {
                            return "e-mail cant be less than 5 letter";
                          }
                          return null;
                        },
                        controller: AuthCubit.get(context).emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: "E-mail Address",
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      responsive.sizedBoxH10,
                      TextFormField(
                        obscureText: AuthCubit.get(context).passwordState,
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
                        controller: AuthCubit.get(context).passwordController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                AuthCubit.get(context).changePasswordState();
                              },
                              icon: AuthCubit.get(context).passwordState
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      responsive.sizedBoxH10,
                      state is EmailError
                          ? Text(
                              "Email or Password not correct",
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox(),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text("Login"),
                            onPressed: () {
                              if (formState.currentState!.validate()) {
                                AuthCubit.get(context).userLogin(
                                    email: AuthCubit.get(context)
                                        .emailController
                                        .text,
                                    password: AuthCubit.get(context)
                                        .passwordController
                                        .text);
                              }
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("forget password?"),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, Routes.resetPassword);
                              },
                              child: const Text("Reset"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?"),
                          TextButton(
                              onPressed: () {
                                navigateToAndReplacement(
                                    context, Routes.register);
                              },
                              child: const Text("Register"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                navigateToAndReplacement(
                                    context, Routes.appLayout);
                              },
                              child: const Text("Skip"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
