import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
class TranslateBox extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final String image;
  const TranslateBox({Key? key, required this.color, required this.icon, required this.text, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ThemeProvider themeProvider, child) {
          return Container(
            padding: EdgeInsets.all(20),

            height: 150,
            width: 180,
            decoration: BoxDecoration(
              boxShadow: [
                themeProvider.isDarkMode?BoxShadow(

                  // offset: Offset(0, 2),
                  // blurRadius: 5,
                  // spreadRadius: 7,
                ):BoxShadow(

                  offset: Offset(0, 1),
                  // blurRadius: 2,
                  // spreadRadius: 3,
                )

              ],
              borderRadius: BorderRadius.circular(30),
              color: color,

            ),
            child: Column(
              children: [
                Text(text, style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: themeProvider.isDarkMode?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                )),
                SizedBox(height: 20,),
                Row(
                  children: [
                    CircleAvatar(
                      child: IconButton(icon: Icon(icon), onPressed: () {

                      },),
                      backgroundColor: themeProvider.isDarkMode?Colors.white70:Colors.black54,
                      foregroundColor: themeProvider.isDarkMode?Colors.black:Colors.white,),
                    Spacer(),
                    Image.asset(image, width: 100, height: 80)

                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}
