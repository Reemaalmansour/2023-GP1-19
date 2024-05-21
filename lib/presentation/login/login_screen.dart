import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';
import '../home screen/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, state) async {
          if (state is UserLoginSuccess) {
            await HomeCubit.get(context).getUserData().then((value) {
              navigateToAndReplacement(context, AppRoutes.appLayout);
            });
          }
          if (state is AuthErrorOccurred) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.error,
              ),
            );
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
                      child: Image.asset(AppAssets.logo),
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
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
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
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: .5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  responsive.sizedBoxH10,
                  state is EmailError
                      ? const Text(
                          "Email or Password not correct",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          await AuthCubit.get(context).userLogin(
                            email: AuthCubit.get(context).emailController.text,
                            password:
                                AuthCubit.get(context).passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("forget password?"),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, AppRoutes.resetPassword);
                        },
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?"),
                      TextButton(
                        onPressed: () {
                          navigateToAndReplacement(
                            context,
                            AppRoutes.register,
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          navigateToAndReplacement(
                            context,
                            AppRoutes.appLayout,
                          );
                        },
                        child: const Text("Skip"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
