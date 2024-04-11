import 'package:ai_chat/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    this.obscureText
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

  @override
  Widget build(BuildContext context) {
    SettingsProvider _settingsProvider = context.watch<SettingsProvider>();

    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          filled: filled,
          isDense: isDense,
          contentPadding: contentPadding,
          fillColor: _settingsProvider.appSettings?.theme == "dark" ? Color(0xFF1f1f1f) : Colors.white,
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : Color(0xFF1f1f1f)
          ),
          prefixIcon: prefixIcon != null ? Icon(
            prefixIcon,
            color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white : Color(0xFF1f1f1f),
          ) : null,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
          )
      ),
      style: GoogleFonts.raleway(
        color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white : Color(0xFF1f1f1f),
        fontSize: getFontSize(16, context).toDouble()
      ),
    );
  }
}
