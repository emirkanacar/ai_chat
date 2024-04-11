import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../helpers/functions.dart';
import '../../providers/SettingsProvider.dart';
import '../ButtonWithIcon.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.onTap,
    required this.onDeleteButtonTap,
    required this.title,
    required this.description,
    required this.date
  }) : super(key: key);

  final void Function() onTap;
  final void Function() onDeleteButtonTap;
  final String title;
  final String description;
  final String date;

  @override
  Widget build(BuildContext context) {
    SettingsProvider? _settingsProvider = context.watch<SettingsProvider>();
    Jiffy.setLocale(_settingsProvider.appSettings?.language ?? "tr");

    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 4),
      decoration: BoxDecoration(
          color: _settingsProvider.appSettings?.theme == "dark" ? Colors.black.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.fromBorderSide(BorderSide(color: _settingsProvider.appSettings?.theme == "dark" ? Colors.white24 : Color(0xFFC9C9C9)))
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: getFontSize(16, context).toDouble()
                          ),
                          overflow: TextOverflow.clip
                      ),
                      Text(description,
                        style: GoogleFonts.raleway(
                          textStyle: Theme.of(context).textTheme.labelSmall,
                          fontWeight: FontWeight.w500,
                          fontSize: getFontSize(14, context).toDouble(),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      Text(Jiffy.parse(date).fromNow(), style: GoogleFonts.raleway(
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          fontWeight: FontWeight.w500,
                          fontSize: getFontSize(13, context).toDouble()
                      ),)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ButtonWithIcon(
                    icon: HeroIcons.trash,
                    onPressed: onDeleteButtonTap,
                    iconSize: 20
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
