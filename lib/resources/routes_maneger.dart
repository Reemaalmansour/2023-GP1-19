import 'package:flutter/material.dart';
import 'package:novoy/presentation/login/reset_password.dart';
import 'package:novoy/presentation/login/sendResetPasswordLink.dart';
import 'package:novoy/presentation/profile/profile_screen.dart';

import 'package:novoy/resources/strings_maneger.dart';
import '../presentation/favorite/favorite_screen.dart';
import '../presentation/home screen/home_screen.dart';
import '../presentation/layout/app_layout.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/login/register_screen.dart';
import '../presentation/trip_screen/trip_screen.dart';
import '../splash_screen/splash_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String register = "register";
  static const String login = "login";
  static const String appLayout = "appLayout";
  static const String homeScreen = "/homeScreen";
  static const String profileScreen = "/profileScreen";
  static const String favoriteScreen = "/favoriteScreen";
  static const String tripScreen = "/tripScreen";
  static const String resetPasswordLinkSend = "/resetPasswordLinkSend";
  static const String resetPassword = "/resetPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.appLayout:
        return MaterialPageRoute(builder: (_) => AppLayout());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case Routes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => FavoriteScreen());
      case Routes.tripScreen:
        return MaterialPageRoute(builder: (_) => TripScreen());
      case Routes.resetPasswordLinkSend:
        return MaterialPageRoute(builder: (_) => ResetPasswordLinkSend());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings
                    .noRoutesFound), // todo move this string to strings manager
              ),
              body: const Center(
                  child: Text(AppStrings
                      .noRoutesFound)), // todo move this string to strings manager
            ));
  }
}
