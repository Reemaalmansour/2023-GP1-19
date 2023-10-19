import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novoy/shared/component/component.dart';
import '../presentation/login/cubit/cubit.dart';
import '../resources/assets_maneger.dart';
import '../resources/color_maneger.dart';
import '../resources/constant_maneger.dart';
import '../resources/responsive.dart';
import '../resources/routes_maneger.dart';
import '../shared/network/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String route;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.splashLogo), fit: BoxFit.cover)),
        child: Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorManager.primary),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      navigateToAndReplacement(context, Routes.login);
                    },
                    child: Text(
                      'Get Started',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: ColorManager.white),
                    )))),
      ),
    );
  }
}
