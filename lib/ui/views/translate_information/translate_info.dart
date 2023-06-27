import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TranslateBox extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final String image;
  const TranslateBox({Key? key, required this.color, required this.icon, required this.text, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      height: 150,
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0,2),

              blurRadius: 5,
              spreadRadius: 7,
            )
          ],
          borderRadius: BorderRadius.circular(30),
    color: color,

    ),
      child: Column(
        children: [
          Text(text, style: GoogleFonts.poppins(
        fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold,
      )),
          SizedBox(height: 20,),
          Row(
            children: [
              CircleAvatar(child: IconButton(icon: Icon(icon), onPressed:(){

              } ,),backgroundColor: Colors.white70,foregroundColor: Colors.black,),
              Spacer(),
              Image.asset(image, width: 100,height:80)

            ],
          ),
        ],
      ),
    );
  }
}
