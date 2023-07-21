

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/ui/res/components/app_elevated_button.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ThemeProvider themeProvider, child) {
          return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  themeProvider.isDarkMode?BoxShadow(

                    offset: Offset(0, 2),
                    // blurRadius: 4,
                    spreadRadius: 7,
                    blurStyle: BlurStyle.solid
                  ):BoxShadow(

                    offset: Offset(0, 1),
                    // blurRadius: 2,
                    // spreadRadius: 3,
                  )
                ],
                borderRadius: BorderRadius.circular(5),
                color: themeProvider.isDarkMode?Colors.grey.withOpacity(.17):Colors.grey.shade100,
                // color: Colors.black12,
              ),
              padding: EdgeInsets.all(10),
              height: 220,
              child: Column(
                children: [
                  Text(
                    'Motion-Verse is a sign language translator designed and developed by Praise Odeyemi and Joshua Ayoola under the supervision of Dr.Mrs Omodunbi.',
                    style: GoogleFonts.poppins(color: themeProvider.isDarkMode?Colors.white:Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),),
                  SizedBox(height: 10),
                  SizedBox(
                      width: 200,
                      child: AppElevatedButton(label: 'Contact us',
                        isLoading: false,
                        borderColor: Colors.transparent,
                        buttonColor: themeProvider.isDarkMode?Colors.grey:Colors.black,
                        textColor: themeProvider.isDarkMode?Colors.black:Colors.white,
                        onPressed: () {

                        },)),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text('©2023', style: GoogleFonts.poppins(
                          color: themeProvider.isDarkMode?Colors.white:Colors.black, fontSize: 14),))
                ],
              )
          );
        }
    );
  }
}
