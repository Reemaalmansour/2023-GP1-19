import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/presentation/home%20screen/cubit/cubit.dart';
import 'package:novoy/presentation/profile/cubit/profile_cubit.dart';
import 'package:novoy/resources/routes_maneger.dart';
import 'package:novoy/shared/component/component.dart';

import '../../presentation/login/cubit/cubit.dart';
import '../../presentation/login/cubit/state.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  Widget buildDrawerHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(20)),
          height: responsive.sHeight(context) * .2,
          width: responsive.sWidth(context) * .45,
          child: Image.asset(ImageAssets.logo),
        ),
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leading,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leading,
        color: ColorManager.primary,
      ),
      title: Text(title),
      onTap: onTap,
      trailing: trailing ??= Icon(
        Icons.arrow_forward_ios,
        color: ColorManager.primary,
      ),
    );
  }

  Widget buildDrawerListItemDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (BuildContext context, state) => ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 280,
              child: DrawerHeader(
                decoration: BoxDecoration(color: ColorManager.primary),
                child: buildDrawerHeader(context),
              ),
            ),
            FirebaseAuth.instance.currentUser?.uid == null
                ? SizedBox()
                : buildDrawerListItem(
                    leading: Icons.person,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.profileScreen).then(
                          (value) => ProfileCubit.get(context).getUserData());
                    }),
            buildDrawerListItem(
                leading: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  AuthCubit.get(context).logOut(context);
                }),
            buildDrawerListItem(
                leading: Icons.delete,
                title: 'Delete Account',
                onTap: () async {
                  await ProfileCubit.get(context)
                      .deleteAccount()
                      .then((value) => AuthCubit.get(context).logOut(context));
                }),
          ],
        ),
      ),
    );
  }
}
