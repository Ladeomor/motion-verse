import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:montion_verse/ui/views/dictionary_screen/dictionary.dart';
import 'package:montion_verse/ui/views/front_camera_screen/camera.dart';
import 'package:montion_verse/ui/views/welcome_screen/welcome.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
class MainScreen extends StatefulWidget {
  final CameraDescription? camera;

  const MainScreen({Key? key, @required this.camera,}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  int _currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<String> name = ['Menu', 'Camera', 'Dictionary'];
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon:  Icon(Icons.home, size: 20),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.camera, size: 20),
        label: 'Camera'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu_book, size:20),
      label: 'Dictionary',),

  
  ];

  @override
  Widget build(BuildContext context) {
          return Consumer(
              builder: (context, ThemeProvider themeProvider, child) {
                return Scaffold(
                  body: PageView(
                    reverse: true,
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: [
                      WelcomeScreen(camera: widget.camera,),
                      Camera(camera: widget.camera,),
                      DictionaryScreen(),

                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(

                    unselectedItemColor: themeProvider.isDarkMode?Colors.white70:Colors.black54,
                    elevation: 0,
                    selectedItemColor: themeProvider.isDarkMode?Colors.white:Colors.black,
                    selectedIconTheme: const IconThemeData(size: 30),
                    currentIndex: _currentIndex,
                    items: _bottomNavigationBarItems,
                    backgroundColor: themeProvider.isDarkMode?Colors.black:Colors.white,
                    type: BottomNavigationBarType.fixed,
                    onTap: (index) {
                      // _pageController.jumpTo(index.toDouble());
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutSine);
                    },
                  ),
                );
              }
          );
  }
}
