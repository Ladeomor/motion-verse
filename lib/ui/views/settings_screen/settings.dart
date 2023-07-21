

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Consumer(
        builder: (context, FontControlProvider fontProvider, child) {
         return Scaffold(
           appBar: AppBar(
             centerTitle: true,
             title: Text(
                 'Settings', style: GoogleFonts.poppins(
                 fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
             )
             ),
             backgroundColor: Colors.transparent,
             elevation: 0,
             automaticallyImplyLeading: true,

           ),
           backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                    16 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.white,),


                    ListTile(
                      dense: true,

                      title:Text(
                        "Dictionary Font size adjustment",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      trailing:IconButton(
                        icon: Icon(Icons.font_download),
                        color: Colors.white
                        , onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
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
                                        color: Colors.black)),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Slider(
                                          min: 0,
                                          max: 100.0,
                                          activeColor: Colors.black,
                                          inactiveColor: const Color(0xFFD0D3D5),
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
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.white,),

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
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                    Divider(color: Colors.white,),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
