import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/functions.dart';

class PromptBox extends StatelessWidget {
  const PromptBox({
    Key? key,
    required this.promptText,
    required this.onTap,
  }) : super(key: key);

  final String promptText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.fromBorderSide(BorderSide(color: Theme.of(context).dividerColor))
        ),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            radius: 15,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(promptText, style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: getFontSize(12, context).toDouble()
              ),
              ),
            ),
          ),
        )
    );
  }
}
