
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/data/dictionary_data.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:montion_verse/view_models/provider/font_provider.dart';
import 'package:provider/provider.dart';

class DictionaryDetails extends StatelessWidget {
  final SignLanguage signLanguage;

  const DictionaryDetails({Key? key, required this.signLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer(
        builder: (context, ThemeProvider themeProvider, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              title: Text(
                  'Sign Dictionary', style: GoogleFonts.poppins(
                  fontSize: 20, color: themeProvider.isDarkMode?Colors.white:Colors.black, fontWeight: FontWeight.bold
              )
              ),
            ),
            backgroundColor: themeProvider.isDarkMode?Colors.black:Colors.white,
            body: Consumer(
                builder: (context, FontControlProvider fontProvider, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 20, right: 20),
                      child: Column(
                        children: [
                          Image.network(
                              signLanguage.signLanguageImage.toString()),
                          SizedBox(height: 20,),

                          Align(alignment: Alignment.centerLeft,
                              child: Text("Sign Language ${signLanguage
                                  .signLanguage}", style: GoogleFonts.poppins(
                                color: themeProvider.isDarkMode?Colors.white:Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,),)),
                          SizedBox(height: 10,),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: 70
                            ),
                            child: Text(signLanguage.signLanguageTranslation,
                              style: GoogleFonts.poppins(
                                  color: themeProvider.isDarkMode?Colors.white:Colors.black,
                                  fontSize: fontProvider.currFontSize),),
                          )


                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}
