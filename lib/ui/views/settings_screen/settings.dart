

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:montion_verse/view_models/provider/font_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themePref = Provider.of<ThemeProvider>(context);

    return Consumer(
        builder: (context, FontControlProvider fontProvider, child) {
         return Scaffold(
           appBar: AppBar(
             centerTitle: true,
             title: Text(
                 'Settings', style: GoogleFonts.poppins(
                 fontSize: 20, color: themePref.isDarkMode?Colors.white:Colors.black, fontWeight: FontWeight.bold
             )
             ),
             backgroundColor: Colors.transparent,
             elevation: 0,
             automaticallyImplyLeading: true,

           ),
           backgroundColor: themePref.isDarkMode?Colors.black:Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                    16 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: themePref.isDarkMode?Colors.white:Colors.black,),


                    ListTile(
                      dense: true,

                      title:Text(
                        "Dictionary Font size adjustment",
                        style: GoogleFonts.poppins(color: themePref.isDarkMode?Colors.white:Colors.black),
                      ),
                      trailing:IconButton(
                        icon: Icon(Icons.font_download),
                        color: themePref.isDarkMode?Colors.white:Colors.black
                        , onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: themePref.isDarkMode?Colors.grey.shade100:Colors.black54,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: const [BoxShadow(blurRadius: 1)]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Font size (px)",
                                    style: GoogleFonts.poppins(
                                        color: themePref.isDarkMode?Colors.black:Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                      color: themePref.isDarkMode?Colors.black:Colors.white),
                                    ),
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,color: themePref.isDarkMode?Colors.black:Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Slider(
                                          min: 0,
                                          max: 100.0,
                                          activeColor: themePref.isDarkMode?Colors.black:Colors.white,
                                          inactiveColor: themePref.isDarkMode?Color(0xFFD0D3D5):Colors.black54,
                                          value: fontProvider.currFontSize
                                              .toDouble(),
                                          onChanged: (double value) {
                                            fontProvider.fontSize = value;
                                          }),
                                    ),
                                    Text(
                                      fontProvider.currFontSize
                                          .round()
                                          .toString(),
                                      style: GoogleFonts.poppins(color: themePref.isDarkMode?Colors.black:Colors.white),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: themePref.isDarkMode?Colors.white:Colors.black,),

                    ListTile(
                      dense: true,
                      // onTap: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) {
                      //       return const HelpAndSupport();
                      //     },
                      //   ));
                      // },
                      title: Text(
                        "Help & support",
                        style: GoogleFonts.poppins(color: themePref.isDarkMode?Colors.white:Colors.black),
                      ),
                      trailing:  Icon(
                        Icons.arrow_forward_ios,
                        color: themePref.isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                    Divider(color: themePref.isDarkMode?Colors.white:Colors.black,),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
