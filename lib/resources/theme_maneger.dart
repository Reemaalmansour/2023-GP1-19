import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novoy/resources/styles_maneger.dart';
import 'package:novoy/resources/value_maneger.dart';

import 'color_maneger.dart';
import 'font_maneger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary.withOpacity(.5),
    // ripple effect color

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: ColorManager.white,
      elevation: AppSize.s0,
      shadowColor: ColorManager.lightPrimary,
      foregroundColor: ColorManager.primary,
      titleTextStyle: getBoldStyle(
        fontSize: FontSize.s22,
        color: ColorManager.black,
      ),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary.withOpacity(.5),
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s17,
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text button them
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s17,
        ),
        foregroundColor: ColorManager.blue,
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s25,
      ),
      headlineLarge: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s22,
      ),
      headlineSmall: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s22,
      ),
      titleLarge:
          getBoldStyle(color: ColorManager.black, fontSize: FontSize.s30),
      titleMedium: getMediumStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s15,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.blueGray,
        fontSize: FontSize.s15,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s17,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s12,
      ),
    ),
    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      labelStyle:
          getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
      prefixStyle: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      prefixIconColor: ColorManager.darkGrey,
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border style
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused border style
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // error border style
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      // focused border style
      focusedErrorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

    //bottom nav
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.white,
      unselectedItemColor: ColorManager.white.withOpacity(.7),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorManager.primary,
      type: BottomNavigationBarType.fixed,
    ),
    iconTheme: IconThemeData(
      color: ColorManager.primary,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.primary,
    ),
  );
}
