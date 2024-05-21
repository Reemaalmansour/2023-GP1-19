import 'package:flutter/material.dart';

import '../presentation/category/category.dart';
import '../presentation/favorite/favorite_screen.dart';
import '../presentation/home screen/home_screen.dart';
import '../presentation/layout/app_layout.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/login/register_screen.dart';
import '../presentation/trip_screen/trip_screen.dart';
import '../splash_screen/splash_screen.dart';
import '/presentation/create_plan/create_plan.dart';
import '/presentation/edit_plan/edit_plan.dart';
import '/presentation/login/reset_password.dart';
import '/presentation/login/sendResetPasswordLink.dart';
import '/presentation/profile/profile_screen.dart';
import '/resources/strings_maneger.dart';

class AppRoutes {
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
  static const String createPlan = "/createPlan";
  static const String tripDetails = "/tripDetails";
  static const String editplan = "/editplan";
  // category
  static const String category = "/category";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.appLayout:
        return MaterialPageRoute(builder: (_) => AppLayout());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case AppRoutes.tripScreen:
        return MaterialPageRoute(builder: (_) => const TripScreen());
      case AppRoutes.resetPasswordLinkSend:
        return MaterialPageRoute(builder: (_) => const ResetPasswordLinkSend());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case AppRoutes.editplan:
        return MaterialPageRoute(builder: (_) => const EditPlan());
      case AppRoutes.createPlan:
        return MaterialPageRoute(builder: (_) => const CreatePlan());

      case AppRoutes.category:
        final arguments = settings.arguments as List;
        final catTypes = arguments[0] as List<String>;
        final catName = arguments[1] as String;
        return MaterialPageRoute(
          builder: (_) => Category(
            catTypes: catTypes,
            catName: catName,
          ),
        );

      // case Routes.tripDetails:
      //   final tripData = settings.arguments as TripModelN;

      //   return MaterialPageRoute(
      //       builder: (_) => TripDetails(
      //             tripModel: tripData,
      //           ),);

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRoutesFound,
          ), // todo move this string to strings manager
        ),
        body: const Center(
          child: Text(
            AppStrings.noRoutesFound,
          ),
        ), // todo move this string to strings manager
      ),
    );
  }
}
