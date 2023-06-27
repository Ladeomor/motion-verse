import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Color? textColor;
  final Color? buttonColor;
  final Color borderColor;
  const AppElevatedButton(
      {Key? key,
        this.onPressed,
        required this.label,
        required this.isLoading,
        this.buttonColor,
        required this.borderColor,
        this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor),
        ),
        // foregroundColor: MaterialStateProperty.all(AppColor.kGrayNeutralColor),
        overlayColor:
        MaterialStateProperty.all(Colors.grey.shade100),
        fixedSize: MaterialStateProperty.all(
          const Size(375, 48),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10 ,
            ),
          ),
        ),
      ),
      child: isLoading
          ? const Text('Loading...')
          : Text(
        label,
        style: GoogleFonts.poppins(color: textColor),
      ),
    );
  }
}
