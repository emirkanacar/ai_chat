import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/functions.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading
  }) : super(key: key);

  final void Function()? onPressed;
  final String buttonText;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF3b61dc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(width: 0, color: Color(0xFF3b61dc))
      ),
      onPressed: isLoading == true ? null : onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(buttonText, style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: getFontSize(15, context).toDouble()
            ),),
            isLoading == true ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 14,
                width: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.white,
                ),
              )
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
