import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/functions.dart';
import '../../providers/SettingsProvider.dart';
import 'MarkdownStyleBuilder.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.messageText,
    required this.direction,
    required this.messageDate,
    required this.isLoading,
    required this.images,
    required this.selectedModel
  }) : super(key: key);

  final String messageText;
  final bool direction;
  final String messageDate;
  final bool isLoading;
  final List<String> images;
  final int selectedModel;

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeWithTimeZone = DateTime.parse(messageDate);
    SettingsProvider settingsProvider = context.read<SettingsProvider>();
    String model = selectedModel == 0 ? "ChatGPT" : "Gemini";

    return direction ? Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isLoading ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : const Color(0xFF282828),
                  strokeWidth: 2,
                ),
              ),
            ): Container(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                margin: const EdgeInsets.only(right: 10, bottom: 2.5, left: 15),
                decoration: BoxDecoration(
                    color: const Color(0xFF282828),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.3)
                    ),
                    borderRadius: const BorderRadius.only(
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
                    fontSize: getFontSize(16, context).toDouble(),
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(images.first.toString()),
                          width: 250,
                          errorBuilder: (BuildContext imageContext, Object image, StackTrace? error) {
                              return Text(
                                AppLocalizations.of(context)!.chatScreenImageLoadError,
                                style: GoogleFonts.raleway(
                                  textStyle: Theme.of(context).textTheme.labelSmall
                                ),
                              );
                          },
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        messageText,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.raleway(
                          fontSize: getFontSize(16, context).toDouble(),
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
          padding: const EdgeInsets.only(right: 20, bottom: 10),
          child: Text(
            DateFormat('HH:mm').format(dateTimeWithTimeZone),
            style: GoogleFonts.raleway(
              color: settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : const Color(0xFF282828)
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  margin: const EdgeInsets.only(right: 40, bottom: 2.5, left: 10),
                  decoration: BoxDecoration(
                      color: settingsProvider.appSettings?.theme == "dark" ? const Color(
                          0xFF101010) :  Colors.white,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: [
                        Markdown(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          shrinkWrap: true,
                          selectable: true,
                          softLineBreak: true,
                          onTapLink: (text, link, _) {
                            final url = link ?? '/';
                            if (url.startsWith('http')) {
                              launchUrl(Uri.parse(url));
                            }
                          },
                          data: messageText,
                          physics: const NeverScrollableScrollPhysics(),
                          extensionSet: md.ExtensionSet(
                            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                            [md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
                          ),
                          styleSheet: MarkdownStyleSheet(
                            h1: GoogleFonts.raleway(),
                            h2: GoogleFonts.raleway(),
                            a: GoogleFonts.raleway(),
                            p: GoogleFonts.raleway(fontSize: getFontSize(16, context).toDouble()),
                          ),
                          builders: {
                            'code': CodeElementBuilder(settingsProvider.appSettings?.theme ?? "dark", AppLocalizations.of(context)!.chatScreenCopyButton)
                          },
                        ),
                        messageText.contains("```") == false ? Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: settingsProvider.appSettings?.theme == "light" ? const Color(0xff1f1f1f).withOpacity(0.2): const Color(0xff1f1f1f),
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: messageText));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(AppLocalizations.of(context)!.chatScreenCopyButton),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(Iconsax.copy_outline, size: 16,),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ) : Container()
                      ],
                    )
                  )
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            "${DateFormat('HH:mm').format(dateTimeWithTimeZone)} - $model",
            style: GoogleFonts.raleway(
                color: settingsProvider.appSettings?.theme == "dark" ?  Colors.white70 : const Color(0xFF282828)
            ),
          ),
        )
      ],
    );
  }
}
