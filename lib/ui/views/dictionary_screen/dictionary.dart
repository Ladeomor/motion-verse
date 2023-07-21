import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/data/dictionary_data.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:montion_verse/models/dictionary_provider.dart';
import 'package:montion_verse/services.dart';
import 'package:montion_verse/ui/res/components/app_elevated_button.dart';
import 'package:montion_verse/ui/res/components/app_textffield.dart';
import 'package:montion_verse/ui/views/dictionary_screen/dictionary_details.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signLanguageModel = Provider.of<SignLanguageModel>(context);
    final signLanguageService = SignLanguageService(signLanguageModel);

    return Consumer(
        builder: (context, ThemeProvider themeProvider, child) {
          return Scaffold(
            backgroundColor: themeProvider.isDarkMode?Colors.black:Colors.white60,
            appBar: AppBar(

              toolbarHeight: 150,
              title: Column(
                children: [
                  Text(
                      'Sign Dictionary', style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: themeProvider.isDarkMode?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold
                  )
                  ),
                  SizedBox(height: 10,),
                  AppTextField(
                    controller: searchController,
                    onChanged: (value) {
                      signLanguageModel.filterByDictionaryWord(value);
                    },
                    hintText: 'Sign Dictionary',
                    suffixIcon: SearchContainer(onTap: () {
                      signLanguageModel.filterByDictionaryWord(
                          signLanguageModel.searchQuery);
                    }),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search, color: themeProvider.isDarkMode?Colors.white:Colors.black,),
                      onPressed: () {
                        signLanguageModel.filterByDictionaryWord(
                            signLanguageModel.searchQuery);
                      },),)

                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,

            ),
            body: FutureBuilder(
                future: signLanguageService.getSignLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else {
                    // List<SignLanguage> signLanguages = signLanguageModel.signLanguages;
                    List<SignLanguage> signLanguages = signLanguageModel
                        .filteredSignLanguages;
                    if (signLanguages.isEmpty) {
                      return Center(child: Text('No matching results'));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,

                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    // SignLanguage signLanguage = signLanguages[index];
                                    SignLanguage signLanguage = signLanguages[index];

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                              child: DictionaryDetails(
                                                signLanguage: signLanguage,),
                                              type: PageTransitionType
                                                  .leftToRight,
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                '${'${index + 1}'.toString()}.',
                                                style: GoogleFonts.poppins(
                                                    color: themeProvider.isDarkMode?Colors.white:Colors.black,
                                                    fontSize: 12)),
                                            SizedBox(width: 20,),
                                            Text("Sign Language: ${signLanguage
                                                .signLanguage}",
                                              style: GoogleFonts.poppins(
                                                  color: themeProvider.isDarkMode?Colors.white:Colors.black,
                                                  fontSize: 12),),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context,
                                      int index) {
                                    return  Divider(
                                      color: themeProvider.isDarkMode?Colors.white:Colors.black,
                                    );
                                  },
                                  itemCount: signLanguages.length))
                        ],
                      ),
                    );
                  }
                }
            ),
          );
        }
    );
  }
}

class SearchContainer extends StatelessWidget {
  final void Function()? onTap;

  const SearchContainer({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
