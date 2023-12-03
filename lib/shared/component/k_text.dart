import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_maneger.dart';
import '../../resources/font_maneger.dart';

Widget kText({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
  bool? isWhite = false,
  int? maxLines,
  TextDecoration? decoration,
  TextStyle? style,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: style ??
        TextStyle(
          decoration: decoration,
          fontWeight: fontWeight,
          fontSize: fontSize != null ? fontSize.r : 12.r,
          color: isWhite! ? ColorManager.textForm : color,
          fontFamily: FontConstants.fontFamily,
        ),
  );
}
