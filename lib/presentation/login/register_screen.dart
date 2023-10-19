import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: ColorManager.primary,
          backgroundColor: ColorManager.white,
          title: Text("Register"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthRegisterSuccess) {
              navigateToAndReplacement(context, Routes.login);
            }
            if (state is AuthErrorOccurred) {
              if (state.error.isNotEmpty) {
                showToast(
                    msg: "Email is used before", state: ToastStates.ERROR);
              }
            }
          },
          builder: (BuildContext context, state) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
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
                              borderRadius: BorderRadius.circular(50))),
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
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    responsive.sizedBoxH10,
                    state is EmailError
                        ? Text(
                            "Email already used before",
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 15,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          items: [
                            "male",
                            "female",
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
                          value: "male",
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
                              borderRadius: BorderRadius.circular(50))),
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
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuthCubit.get(context).userRegister(
                                age: AuthCubit.get(context).ageController.text,
                                gender: AuthCubit.get(context).gender,
                                name:
                                    AuthCubit.get(context).userController.text,
                                email:
                                    AuthCubit.get(context).emailController.text,
                                phone:
                                    AuthCubit.get(context).phoneController.text,
                                password: AuthCubit.get(context)
                                    .passwordController
                                    .text);
                          } else {
                            return;
                          }
                        },
                        child: const Text("Register"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("have an account ?"),
                        TextButton(
                            onPressed: () {
                              navigateToAndReplacement(context, Routes.login);
                            },
                            child: const Text("Login"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
