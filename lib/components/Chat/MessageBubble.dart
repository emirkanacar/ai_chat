import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/SettingsProvider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.messageText,
    required this.direction,
    required this.messageDate,
    required this.isLoading,
    required this.images,
  }) : super(key: key);

  final String messageText;
  final bool direction;
  final String messageDate;
  final bool isLoading;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeWithTimeZone = DateTime.parse(messageDate);
    SettingsProvider _settingsProvider = context.watch<SettingsProvider>();

    return direction ? Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isLoading ? Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : Color(0xFF282828),
                  strokeWidth: 2,
                ),
              ),
            ): Container(),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                margin: EdgeInsets.only(right: 10, bottom: 2.5, left: 15),
                decoration: BoxDecoration(
                    color: Color(0xFF282828),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.3)
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: images.isEmpty ? Text(
                  messageText,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(File(images.first.toString() ?? ""), width: 250)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        messageText,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, bottom: 10),
          child: Text(
            DateFormat('HH:mm').format(dateTimeWithTimeZone),
            style: GoogleFonts.raleway(
              color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : Color(0xFF282828)
            ),
          ),
        )
      ],
    ) : Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  margin: EdgeInsets.only(right: 40, bottom: 2.5, left: 10),
                  decoration: BoxDecoration(
                      color: _settingsProvider.appSettings?.theme == "dark" ?  Color(
                          0xFF101010) :  Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.0)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Markdown(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      shrinkWrap: true,
                      selectable: true,
                      data: messageText,
                      physics: const NeverScrollableScrollPhysics(),
                      styleSheet: MarkdownStyleSheet(
                        h1: GoogleFonts.raleway(),
                        h2: GoogleFonts.raleway(),
                        a: GoogleFonts.raleway(),
                        p: GoogleFonts.raleway(fontSize: 16),
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            DateFormat('HH:mm').format(dateTimeWithTimeZone),
            style: GoogleFonts.raleway(
                color: _settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : Color(0xFF282828)
            ),
          ),
        )
      ],
    );
  }
}
