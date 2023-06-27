
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/ui/views/front_camera_screen/front_camera.dart';
import 'package:montion_verse/ui/views/main_screen/main.dart';
import 'package:montion_verse/ui/views/welcome_screen/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 10), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('motion-verse', style: GoogleFonts.poppins(
          color: Colors.white, fontSize: 20
        ),),
      ),
    );
  }
}
