import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:google_fonts/google_fonts.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  final String theme;
  final String copyTranslate;

  CodeElementBuilder(this.theme, this.copyTranslate);

  final MediaQueryData data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';
    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    return SizedBox(
      width: data.size.width,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: theme == "light" ? const Color(0xff1f1f1f).withOpacity(0.2): const Color(0xff1f1f1f),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(language),
                Container(
                  decoration: BoxDecoration(
                      color: theme == "light" ? Colors.white : Color(0xFF101010),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: element.textContent));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Text(copyTranslate),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Iconsax.copy_outline, size: 16,),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          HighlightView(
            element.textContent,
            language: language,
            theme: theme == "light" ? atomOneLightTheme : atomOneDarkTheme,
            padding: const EdgeInsets.all(8),
            textStyle: GoogleFonts.robotoMono(),
          )
        ],
      ),
    );
  }
}