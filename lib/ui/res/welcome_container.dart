
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/ui/res/components/app_elevated_button.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(

            offset: Offset(0,2),
            blurRadius: 7,
            spreadRadius: 7,
          )
        ],
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(.17),
        // color: Colors.black12,
      ),
      padding: EdgeInsets.all(10),
      height: 220,
      child:  Column(
        children: [
          Text('Motion-Verse is a sign language translator designed and developed by Praise Odeyemi and Joshua Ayoola under the supervision of Dr.Mrs Omodunbi.', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
              child: AppElevatedButton(label: 'Contact us', isLoading: false, borderColor: Colors.transparent, buttonColor: Colors.grey,textColor:Colors.black,onPressed: (){

              },)),
          Align(
            alignment: Alignment.bottomRight,
              child: Text('©2023', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),))
        ],
      )
    );
  }
}
