import 'package:flutter/material.dart';
import 'package:novoy/resources/color_maneger.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {Key? key,
      this.hint,
      this.label,
      this.prefix,
      this.controller,
      this.validate,
      this.onChanged,
      this.initVal,
      this.textInputType,
      this.readonly,
      this.onTap,})
      : super(key: key);
  final String? hint;
  final String? label;
  final Widget? prefix;
  final String? initVal;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool? readonly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readonly ?? false,
      initialValue: initVal,
      onChanged: onChanged,
      validator: validate,
      controller: controller,
      style: Theme.of(context).inputDecorationTheme.hintStyle,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary),
            borderRadius: BorderRadius.circular(50),),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary),
            borderRadius: BorderRadius.circular(50),),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary),
            borderRadius: BorderRadius.circular(50),),
      ),
    );
  }
}
