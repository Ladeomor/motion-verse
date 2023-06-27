
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/data/dictionary_data.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:montion_verse/view_models/provider/font_provider.dart';
import 'package:provider/provider.dart';

class DictionaryDetails extends StatelessWidget {
  final DictionaryModel dm;

  const DictionaryDetails({Key? key, required this.dm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DictionaryModel> dictonary = dictionaryModel;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: Text(
            'Sign Dictionary', style: GoogleFonts.poppins(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
        )
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer(
        builder: (context, FontControlProvider fontProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Image.asset(dm.signLanguageImage),
                  SizedBox(height: 20,),

                  Align(alignment: Alignment.centerLeft,
                      child: Text(dm.signLanguage, style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,),)),
                  SizedBox(height: 10,),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 70
                    ),
                    child: Text(dm.signLanguageTranslation, style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: fontProvider.currFontSize),),
                  )


                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
