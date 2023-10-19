import 'package:flutter/material.dart';


class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {Key? key,
      this.hint,
      required this.label,
      this.prefix,
      this.controller,
      this.validate,
      this.onChanged,
      this.initVal,
      this.textInputType,
      this.readonly})
      : super(key: key);
  final String? hint;
  final String? label;
  final IconData? prefix;
  final String? initVal;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool? readonly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      initialValue: initVal,
      onChanged: onChanged,
      validator: validate,
      controller: controller,
      style: Theme.of(context).inputDecorationTheme.hintStyle,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(Icons.add_alert_outlined),
        label: Text(label!),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
