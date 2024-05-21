import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../../model/user/user_model.dart';
import '../../resources/strings_maneger.dart';
import '../login/cubit/cubit.dart';
import '/global/global.dart';
import '/presentation/profile/cubit/profile_cubit.dart';
import '/resources/color_maneger.dart';
import '/resources/responsive.dart';
import '/resources/routes_maneger.dart';
import '/shared/component/component.dart';

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
  File? image;
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
                                AppRoutes.register,
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
                              navigateToAndReplacement(
                                context,
                                AppRoutes.login,
                              );
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
                        // Profile Image
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: image != null
                                  ? Image.file(
                                      image!,
                                    )
                                  : user.imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: user.imageUrl!,
                                        )
                                      : Image.asset(
                                          "assets/user.png",
                                          fit: BoxFit.scaleDown,
                                        ),
                            ),

                            // Edit Profile Image
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // show bottom sheet to choose image from gallery or camera
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 100,
                                        color: AppColors.textFiled,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () async {
                                                await Utils.pickImage(
                                                  source: ImageSource.camera,
                                                ).then((value) {
                                                  setState(() {
                                                    image = value;
                                                  });
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              label: const Text("Camera"),
                                              icon: const Icon(Icons.camera),
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                await Utils.pickImage(
                                                  source: ImageSource.gallery,
                                                ).then((value) {
                                                  setState(() {
                                                    image = value;
                                                  });
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              label: const Text("Gallery"),
                                              icon: const Icon(Icons.image),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.textFiled,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        responsive.sizedBoxH10,
                        TextFormField(
                          readOnly: true,
                          controller: userNameController,
                          decoration: InputDecoration(
                            hintText: user.name,
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
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
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                        responsive.sizedBoxH10,
                        TextFormField(
                          controller: phoneController,
                          maxLength: 9,
                          decoration: InputDecoration(
                            hintText: user.phone,
                            prefixIcon: Icon(
                              Icons.call,
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
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
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                        responsive.sizedBoxH10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.primary,
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
                                  value: user.gender,
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
                                      UserModel? newUser =
                                          kUser?.copyWith(gender: val ?? "");
                                      kUser = newUser;

                                      genderController.text = val ?? "";
                                    });
                                  },
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
                                image: image,
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
