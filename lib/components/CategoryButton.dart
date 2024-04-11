import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../helpers/functions.dart';
import '../providers/SettingsProvider.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.buttonText,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    SettingsProvider? _settingsProvider = context.watch<SettingsProvider>();

    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 0),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xff3f69ef).withOpacity(0.05) : _settingsProvider.appSettings?.theme == "dark" ? Colors.black.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(BorderSide(color: isSelected ? Color(0xff3f69ef) : _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)))
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 4),
            child: Text(buttonText, style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(14, context).toDouble(),
                color: isSelected ? const Color(0xff3f69ef) : _settingsProvider.appSettings?.theme == "dark" ? Colors.white : Colors.black.withOpacity(0.7)
            ),),
          )
        ),
      ),
    );
  }
}
