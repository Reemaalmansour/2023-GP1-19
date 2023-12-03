import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: ColorManager.primary,
          backgroundColor: ColorManager.white,
          title: const Text("Register"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthRegisterSuccess) {
              navigateToAndReplacement(context, Routes.login);
            }
            if (state is AuthErrorOccurred) {
              if (state.error.isNotEmpty) {
                showToast(
                  msg: "Email is used before",
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (BuildContext context, state) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
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
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Name can't be empty";
                              }
                              if (value.length > 50) {
                                return "Name can't be more than 50 letter";
                              }
                              if (value.length < 2) {
                                return "Name can't be less than 2 letter";
                              }
                              return null;
                            },
                            controller: AuthCubit.get(context).userController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: "Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "e-mail can't be empty";
                              }
                              if (val.length > 50) {
                                return "e-mail can't be more than 50 letter";
                              }
                              if (val.length < 5) {
                                return "e-mail can't be less than 5 letter";
                              }
                              return null;
                            },
                            controller: AuthCubit.get(context).emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: "firstname@exaple.com",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          state is EmailError
                              ? const Text(
                                  "Email already used before",
                                  style: TextStyle(color: Colors.red),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onTap: () {
                              // 13 years old from now

                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(
                                  const Duration(days: 13 * 365),
                                ),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now().subtract(
                                  const Duration(days: 13 * 365),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    AuthCubit.get(context).ageController.text =
                                        DateFormat.yMMMd().format(value);
                                  });
                                }
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "age cant be empty";
                              }
                              return null;
                            },
                            controller: AuthCubit.get(context).ageController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.numbers),
                              hintText: "Age",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: .5,
                                color: Colors.black,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: [
                                "Male",
                                "Female",
                              ]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      onTap: () {},
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  AuthCubit.get(context).gender = val!;
                                });
                              },
                              value: "Male",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "phone can't be empty";
                              }
                              if (val.length > 50) {
                                return "phone can't be more than 50 letter";
                              }
                              if (val.length < 9) {
                                return "phone can't be less than 9 letter";
                              }
                              return null;
                            },
                            controller: AuthCubit.get(context).phoneController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              hintText: "phone",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: AuthCubit.get(context).passwordState,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "password can't be empty";
                              }
                              if (val.length > 50) {
                                return "password can't be more than 50 letter";
                              }
                              if (val.length < 8) {
                                return "password can't be less than 8 letter";
                              }
                              return null;
                            },
                            controller:
                                AuthCubit.get(context).passwordController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
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
                          const SizedBox(
                            height: 5,
                          ),
                          FlutterPwValidator(
                            minLength: 8,
                            uppercaseCharCount: 1,
                            lowercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            width: 400,
                            height: 165,
                            onSuccess: () {
                              setState(() {
                                isValid = true;
                              });
                            },
                            controller:
                                AuthCubit.get(context).passwordController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("have an account ?"),
                              TextButton(
                                onPressed: () {
                                  navigateToAndReplacement(
                                    context,
                                    Routes.login,
                                  );
                                },
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() && isValid == true) {
                        AuthCubit.get(context).userRegister(
                          age: AuthCubit.get(context).ageController.text,
                          gender: AuthCubit.get(context).gender,
                          name: AuthCubit.get(context).userController.text,
                          email: AuthCubit.get(context).emailController.text,
                          phone: AuthCubit.get(context).phoneController.text,
                          password:
                              AuthCubit.get(context).passwordController.text,
                        );
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.info(
                            message:
                                "Please make sure that all fields are filled and the password is correct",
                          ),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
