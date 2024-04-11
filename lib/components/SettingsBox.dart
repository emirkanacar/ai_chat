import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../helpers/functions.dart';
import '../providers/SettingsProvider.dart';

class SettingsBox extends StatelessWidget {
  const SettingsBox({
    Key? key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.icon,
    this.isFirst,
    this.isLast
  }): super(key: key);

  final void Function() onTap;
  final String title;
  final String description;
  final IconData icon;
  final bool? isFirst;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    SettingsProvider? _settingsProvider = context.watch<SettingsProvider>();

    return Container(
        decoration: BoxDecoration(
          color: _settingsProvider.appSettings?.theme == "dark" ? Color(0xFF1f1f1f) : Colors.white,
          border: isFirst == true ? Border(
            bottom: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            top: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            right: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            left: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
          ) : isLast == true ? Border(
            bottom: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            right: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            left: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
          ) : Border(
            right: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            left: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
            bottom: BorderSide(width: 1.0, color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)),
          ),
          borderRadius: isFirst == true ? BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
        ),
        child: Material(
          borderRadius: isFirst == true ? BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
          color: Colors.transparent,
          child: InkWell(
              borderRadius: isFirst == true ? BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : isLast == true ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.zero,
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(icon, size: 28, color: Theme.of(context).textTheme.bodyLarge?.color,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 0),
                                child: Text(title, style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w600,
                                    fontSize: getFontSize(16, context).toDouble()
                                ),)
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 20, top: 0),
                                child: Text(description, style: GoogleFonts.raleway(
                                  textStyle: Theme.of(context).textTheme.labelSmall,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(14, context).toDouble(),
                                ),)
                            ),
                          ],
                        )
                      ],
                    ),
                    Icon(HeroIcons.chevron_right, size: 24, color: Theme.of(context).textTheme.bodyLarge?.color)
                  ],
                ),
              )
          ),
        )
    );
  }
}
