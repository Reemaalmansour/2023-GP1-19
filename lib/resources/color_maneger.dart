import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = const Color(0xff02A0C6);
  static Color splash = const Color(0xff021F4A);
  static Color black = Colors.black;
  static Color yellow = Colors.yellow;
  static Color star = Colors.amber;
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color grey3 = const Color(0xffd9d9d9);
  static Color lightBlack = const Color(0x86000000);
  static Color blueGray = const Color(0xff3c5767);
  static Color blue = const Color(0xff021F4A);

  static Color textForm = const Color(0xffE1DFDF);
  static Color textFiled = const Color(0xffeeefee);
  static Color card = const Color(0xffEFEFEF);
  static Color scaffold = const Color(0xffEFEFEF);

  static Color story = const Color(0xff1C96A7).withOpacity(.6);
  static LinearGradient linearGradientMain = const LinearGradient(colors: [
    Color(0xff7F339F),
    Color(0xff1C96A7),
  ],);
  static RadialGradient radialGradientCard =
      const RadialGradient(radius: 2, colors: [
    Color(0xffFFFFFF),
    Color(0xffF4F4F4),
    Color(0xffEFEFEF),
  ],);
  static LinearGradient linearGradientMsg = const LinearGradient(colors: [
    Color(0xff27B43D),
    Color(0xff06D81E),
  ],);

  // new colors
  static Color darkPrimary = const Color(0xff116d7a);
  static Color lightPrimary = const Color(0xffC9E9E7); // color with 80% opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34); // red color
}
