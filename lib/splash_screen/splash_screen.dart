import 'package:flutter/material.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../presentation/home screen/cubit/cubit.dart';
import '../resources/assets_maneger.dart';
import '../resources/color_maneger.dart';
import '../resources/routes_maneger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String route;

  @override
  void initState() {
    HomeCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.newSplashLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                child: Column(
                  children: [
                    kText(
                      text: "NOVOY",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    kText(
                      text: "YOUR TRAVEL MATE",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorManager.white,
                ),
                padding: const EdgeInsets.all(20),
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: kText(
                        text: "Let\'s Organize Your Trip.",
                        fontSize: 25,
                        maxLines: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ColorManager.primary),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            kUser != null
                                ? route = Routes.appLayout
                                : route = Routes.login;
                            Navigator.of(context).pushReplacementNamed(route);
                          },
                          child: Text(
                            'Get Started',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: ColorManager.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
