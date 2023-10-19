import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/presentation/profile/cubit/profile_cubit.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/resources/routes_maneger.dart';
import 'package:novoy/shared/component/component.dart';

import '../../resources/strings_maneger.dart';
import '../login/cubit/cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getUserData();
    super.initState();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var user = ProfileCubit.get(context).userData;
          if (state is DataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileErrorOccurred) {
            return const Text(AppStrings.errorMsg);
          }
          return user == null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SizedBox(
                        height: 70,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              navigateToAndReplacement(
                                  context, Routes.register);
                            },
                            child: Text("Register")),
                      )),
                      responsive.sizedBoxH30,
                      Center(
                          child: SizedBox(
                        height: 70,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              navigateToAndReplacement(context, Routes.login);
                            },
                            child: Text("Login")),
                      ))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          hintText: user.name,
                          prefixIcon: Icon(
                            Icons.person,
                            color: ColorManager.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      TextFormField(
                        readOnly: true,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: user.email,
                          prefixIcon: Icon(
                            Icons.email,
                            color: ColorManager.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: user.phone,
                          prefixIcon: Icon(
                            Icons.call,
                            color: ColorManager.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      TextFormField(
                        controller: ageController,
                        decoration: InputDecoration(
                          hintText: user.age,
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: ColorManager.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: user.gender,
                          prefixIcon: Icon(
                            user.gender == "male" ? Icons.male : Icons.female,
                            color: ColorManager.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH30,
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                ProfileCubit.get(context).updateUserData(
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  age: ageController.text,
                                );
                              },
                              child: Text("Edit Profile"))),
                      responsive.sizedBoxH30,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content:
                                      Text("Are you sure you want to log out?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Logout"),
                                      onPressed: () {
                                        AuthCubit.get(context).logOut(context);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("LogOut"),
                        ),
                      ),
                      responsive.sizedBoxH30,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Are you sure you want to delete your account?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Delete"),
                                      onPressed: () async {
                                        await ProfileCubit.get(context)
                                            .deleteAccount()
                                            .then((value) {
                                          // Logout after successful deletion
                                          AuthCubit.get(context)
                                              .logOut(context);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("Delete Account"),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
