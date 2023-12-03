import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:novoy/global/global.dart';
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
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  @override
  void initState() {
    userNameController.text = kUser?.name ?? "";
    emailController.text = kUser?.email ?? "";
    phoneController.text = kUser?.phone ?? "";
    ageController.text = kUser?.age ?? "";
    genderController.text = kUser?.gender ?? "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    genderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var user = kUser;
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
                                context,
                                Routes.register,
                              );
                            },
                            child: const Text("Register"),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH30,
                      Center(
                        child: SizedBox(
                          height: 70,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              navigateToAndReplacement(context, Routes.login);
                            },
                            child: const Text("Login"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
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
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
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
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
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
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                          ),
                        ),
                        responsive.sizedBoxH10,
                        TextFormField(
                          onTap: () {
                            // initialDate is 13 years ago from now
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
                              if (value != null)
                                ageController.text =
                                    DateFormat.yMMMd().format(value);
                            });
                          },
                          readOnly: true,
                          controller: ageController,
                          decoration: InputDecoration(
                            hintText: user.age,
                            prefixIcon: Icon(
                              Icons.numbers,
                              color: ColorManager.primary,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                            ),
                          ),
                        ),
                        responsive.sizedBoxH10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorManager.primary,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                user.gender!.toLowerCase() == 'male'
                                    ? Icons.male
                                    : Icons.female,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width - 65,
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
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      kUser?.gender = val ?? "";
                                      genderController.text = val ?? "";
                                    });
                                  },
                                  value: user.gender,
                                ),
                              ),
                            ],
                          ),
                        ),
                        responsive.sizedBoxH30,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ProfileCubit.get(context).updateUserData(
                                name: userNameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                age: ageController.text,
                                gender: genderController.text,
                              );
                            },
                            child: const Text("Edit Profile"),
                          ),
                        ),
                        responsive.sizedBoxH30,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: const Text(
                                      "Are you sure you want to log out?",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Logout"),
                                        onPressed: () {
                                          AuthCubit.get(context)
                                              .logOut(context);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("LogOut"),
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
                                    content: const Text(
                                      "Are you sure you want to delete your account?",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Delete"),
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
                            child: const Text("Delete Account"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
