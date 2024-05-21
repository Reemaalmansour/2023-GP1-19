import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '/resources/color_maneger.dart';

import '../resources/routes_maneger.dart';
import '../resources/theme_maneger.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) {
            //ignored progress for the moment
            return Center(
              child: SpinKitFoldingCube(
                color: AppColors.primary,
                size: 50.0,
              ),
            );
          },
          overlayColor: Colors.black.withOpacity(0.5),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: AppRoutes.splashRoute,
            theme: getApplicationTheme(),
          ),
        );
      },
    );
  }
}
