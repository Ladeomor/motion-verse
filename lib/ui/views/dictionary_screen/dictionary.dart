import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/data/dictionary_data.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:montion_verse/ui/res/components/app_elevated_button.dart';
import 'package:montion_verse/ui/res/components/app_textffield.dart';
import 'package:montion_verse/ui/views/dictionary_screen/dictionary_details.dart';
import 'package:page_transition/page_transition.dart';


class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DictionaryModel> dictonary = dictionaryModel;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 150,
        title: Column(
          children: [
            Text(
                'Sign Dictionary', style: GoogleFonts.poppins(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
            )
            ),
            SizedBox(height: 10,),
            AppTextField(hintText: 'Sign Dictionary', suffixIcon: SearchContainer(),prefixIcon: IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {

            },),)

          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
              scrollDirection: Axis.vertical,

                itemBuilder: (BuildContext context, int index){
                  final dd = dictonary[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                            child: DictionaryDetails(dm: dd),
                            type: PageTransitionType.leftToRight,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text('${'${index+1}'.toString()}.',style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                          Text(dd.signLanguage, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),),
                        ],
                      ),
                    ),
                  );
            }, separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.white,
                );
            }, itemCount: dictonary.length))
          ],
        ),
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      splashColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),

          ),
          child: Center(child: Text('Search', style: GoogleFonts.poppins(fontSize: 15),)),



        ),
      ),
    );
  }
}
