import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/ui/res/components/carousel_slide.dart';
import 'package:montion_verse/ui/res/welcome_container.dart';
import 'package:montion_verse/ui/views/dictionary_screen/dictionary.dart';
import 'package:montion_verse/ui/views/front_camera_screen/camera.dart';
import 'package:montion_verse/ui/views/front_camera_screen/front_camera.dart';
import 'package:montion_verse/ui/views/settings_screen/settings.dart';
import 'package:montion_verse/ui/views/translate_information/translate_info.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        title: Text(
          'Sign Language', style: GoogleFonts.poppins(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
        )
        ),
        backgroundColor: Colors.transparent,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(backgroundColor: Colors.white,radius: 15,child: IconButton(icon:Icon(Icons.brightness_2_outlined), iconSize: 15, color: Colors.black,onPressed: (){

          },), ),
          SizedBox(width: 5,),
          CircleAvatar(backgroundColor: Colors.white,radius: 15,child: IconButton(icon:Icon(Icons.settings), iconSize: 15, color: Colors.black,onPressed: (){
            Navigator.push(
                context,
                PageTransition(
                  child: const SettingsScreen(),
                  type: PageTransitionType.leftToRight,
                ));
          },), )

        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [

              CarouselSlide(),

              SizedBox(height: 40,),
              Align(
                alignment: Alignment.topLeft,
                child: Text('About Motion-verse',style: GoogleFonts.poppins(
                    fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(height: 20,),

              WelcomeContainer(),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Start Translating',style: GoogleFonts.poppins(
                  fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(height: 20,),

              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                child: const Camera(),
                                type: PageTransitionType.leftToRight,
                              ));
                        },
                        child: TranslateBox(color: Colors.grey.withOpacity(.17), icon: Icons.camera_alt, text: 'Translate your Sign Language', image: 'assets/images/dictionary_illus.jpg')),
                    SizedBox(width: 20,),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                child: const DictionaryScreen(),
                                type: PageTransitionType.leftToRight,
                              ));
                        },
                        child: TranslateBox(color: Colors.grey.withOpacity(.17), icon: Icons.menu_book_rounded, text: 'Dictionary of Sign Languages', image: 'assets/images/translate_in.jpg')),

                  ],
                ),
              )

            ],
          ),
        ),

      )
    );
  }
}