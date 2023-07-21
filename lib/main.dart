import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montion_verse/models/dictionary_provider.dart';
import 'package:montion_verse/ui/views/front_camera_screen/front_camera.dart';
import 'package:montion_verse/ui/views/front_camera_screen/live_camera.dart';
import 'package:montion_verse/ui/views/splash_screen/splash_screen.dart';
import 'package:montion_verse/view_models/provider/font_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

 await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  cameras = await availableCameras();

  try{
    cameras = await availableCameras();

  }on CameraException catch (e){
    print('Error in fetching the cameras: $e');

  }
  runApp(MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => FontControlProvider()),
        ChangeNotifierProvider(create: (_) => SignLanguageModel()),


      ],

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'motion-verse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: SplashScreen(),
    );
  }
}

