import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/resources/styles_maneger.dart';
import '/resources/value_maneger.dart';
import 'color_maneger.dart';
import 'font_maneger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    // main colors
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.lightPrimary,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.grey1,
    splashColor: AppColors.lightPrimary.withOpacity(.5),
    // ripple effect color

    // card view theme
    cardTheme: CardTheme(
      color: AppColors.white,
      shadowColor: AppColors.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: AppColors.white,
      elevation: AppSize.s0,
      shadowColor: AppColors.lightPrimary,
      foregroundColor: AppColors.primary,
      titleTextStyle: getBoldStyle(
        fontSize: FontSize.s22,
        color: AppColors.black,
      ),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: AppColors.grey1,
      buttonColor: AppColors.primary,
      splashColor: AppColors.lightPrimary.withOpacity(.5),
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: AppColors.white,
          fontSize: FontSize.s17,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text button them
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: getRegularStyle(
          color: AppColors.primary,
          fontSize: FontSize.s17,
        ),
        foregroundColor: AppColors.blue,
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
        color: AppColors.primary,
        fontSize: FontSize.s25,
      ),
      headlineLarge: getBoldStyle(
        color: AppColors.black,
        fontSize: FontSize.s20,
      ),
      headlineMedium: getRegularStyle(
        color: AppColors.darkGrey,
        fontSize: FontSize.s22,
      ),
      headlineSmall: getBoldStyle(
        color: AppColors.black,
        fontSize: FontSize.s22,
      ),
      titleLarge: getBoldStyle(color: AppColors.black, fontSize: FontSize.s30),
      titleMedium: getMediumStyle(
        color: AppColors.darkGrey,
        fontSize: FontSize.s15,
      ),
      titleSmall: getRegularStyle(
        color: AppColors.blueGray,
        fontSize: FontSize.s15,
      ),
      bodyLarge: getRegularStyle(
        color: AppColors.black,
        fontSize: FontSize.s17,
      ),
      bodySmall: getRegularStyle(
        color: AppColors.primary,
        fontSize: FontSize.s12,
      ),
    ),
    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRegularStyle(
        color: AppColors.darkGrey,
        fontSize: FontSize.s14,
      ),
      labelStyle:
          getMediumStyle(color: AppColors.black, fontSize: FontSize.s14),
      prefixStyle: getRegularStyle(
        color: AppColors.darkGrey,
        fontSize: FontSize.s14,
      ),
      prefixIconColor: AppColors.darkGrey,
      errorStyle: getRegularStyle(color: AppColors.error),

      // enabled border style
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused border style
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // error border style
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      // focused border style
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

    //bottom nav
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white.withOpacity(.7),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: AppColors.primary,
      type: BottomNavigationBarType.fixed,
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.primary,
    ),
  );
}
