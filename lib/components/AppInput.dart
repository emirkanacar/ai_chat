import 'package:flutter/material.dart';

import '../helpers/functions.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.filled,
    this.readOnly,
    this.isDense,
    this.contentPadding,
    this.maxLines,
    this.obscureText,
    this.suffixIcon
  }) : super(key: key);

  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool? filled;
  final String? hintText;
  final bool? readOnly;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final bool? obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          filled: filled,
          isDense: isDense,
          contentPadding: contentPadding,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(
            prefixIcon,
          ) : null,
          suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontSize: getFontSize(16, context).toDouble()
      ),
    );
  }
}
