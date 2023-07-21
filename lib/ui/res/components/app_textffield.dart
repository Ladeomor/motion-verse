

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const AppTextField(
      {Key? key,
        this.controller,
        this.focusNode,
        this.textInputAction,
        this.onSubmitted,
        this.onChanged,
        this.validator,
        this.prefixIcon,
        this.suffixIcon,
        required this.hintText,
        this.obscureText = false,
        this.keyboardType,  AutovalidateMode? autoValidateMode, String? errorText,  int? maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onFieldSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              validator: validator,
              onChanged: onChanged,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                  BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                  BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                  BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                      color: Colors.transparent,
                     ),
                ),
                hintStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                contentPadding: const EdgeInsets.only(
                    bottom: 20,
                    right: 5,
                    left: 5),
                fillColor: Colors.grey,
                filled: true,
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 64,
                  minHeight: 20,
                  maxHeight: 30
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 64,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
