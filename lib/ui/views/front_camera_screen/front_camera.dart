import 'dart:io';
import 'dart:math' as math;
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montion_verse/services/camera-service.dart';
import 'package:montion_verse/services/tensorflow-service.dart';
import 'package:montion_verse/ui/views/front_camera_screen/widgets/camera-header.dart';
import 'package:montion_verse/ui/views/front_camera_screen/widgets/recognition.dart';
List<CameraDescription>? cameras;

class FrontCamera extends StatefulWidget {
  const FrontCamera({Key? key}) : super(key: key);

  @override
  _FrontCameraState createState() => _FrontCameraState();
}

class _FrontCameraState extends State<FrontCamera>  with TickerProviderStateMixin, WidgetsBindingObserver{

  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool flash = false;
  bool isFrontCamera = true;
  var cameraCount = 0;
  bool isRecording = false;
  double transform = 0;
  bool isDetecting = false;


  bool isCameraInitialized = false;
  final TensorflowService _tensorflowService = TensorflowService();
  final CameraService _cameraService = CameraService();


  late AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    initializeCamera();
  }

  startRecognitions() async {
    try {
      // starts the camera stream on every frame and then uses it to recognize the result every 1 second
      _cameraService.startStreaming();
    } catch (e) {
      print('error streaming camera image');
      print(e);
    }
  }

  stopRecognitions() async {
    // closes the streams
    await _cameraService.stopImageStream();
    await _tensorflowService.stopRecognitions();
  }


  void initializeCamera()async{
    if(cameraValue == null){
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue= _cameraController!.initialize().then((value) async{
      await _tensorflowService.loadModel();
      startRecognitions();
    });

    if(!mounted)return;
    setState(() {
      isCameraInitialized = true;
    });
  }else{
      await _tensorflowService.loadModel();
      startRecognitions();
    }
  }




  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
    _cameraService.dispose();
    _tensorflowService.dispose();
    cameraValue;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done)
                {
                  return Stack(
                    children: [ SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CameraPreview(_cameraController!)),
                      const CameraHeader(),

                      // shows the recognition on the bottom
                      Recognition(
                        ready: true,
                      ),
                ]  );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),

          // shows the recognition on the bottom
          // Positioned(
          //   bottom: 10.0,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.of(context).size.width,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             IconButton(onPressed: (){
          //               setState(() {
          //                 flash = !flash;
          //               });
          //
          //             }, icon: Icon(flash?Icons.flash_on:Icons.flash_off, color: Colors.white,size: 28,),
          //             ),
          //             GestureDetector(
          //                 onLongPress: ()async{
          //                   // final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.mp4");
          //                   await _cameraController!.startVideoRecording();
          //                   setState(() {
          //                     isRecording = true;
          //                   });
          //                 },
          //                 onLongPressUp: ()async{
          //                   XFile videopath =  await _cameraController!.stopVideoRecording();
          //                   setState(() {
          //                     isRecording = false;
          //                   });
          //                   // Navigator.push(context, MaterialPageRoute(builder: (builder) => VideoView(path: videopath.path,)));
          //                 },
          //                 onTap: (){
          //                   takePicture(context);
          //                 }, child: isRecording
          //                 ? const Icon(Icons.radio_button_on, color: Colors.red,size: 80,)
          //                 :
          //             const Icon(Icons.panorama_fish_eye_rounded, color: Colors.white, size: 70,)),
          //             IconButton(onPressed: ()async{
          //
          //               setState(() {
          //                 isFrontCamera = !isFrontCamera;
          //                 transform += pi;
          //               });
          //               int cameraPosition = isFrontCamera ? 0 : 1;
          //               _cameraController = CameraController(
          //                   cameras![cameraPosition], ResolutionPreset.high);
          //               cameraValue= _cameraController!.initialize();
          //               //Transform.rotate rotates camera 180 degrees
          //             }, icon: Transform.rotate(
          //                 angle: transform,
          //                 child: Icon(Icons.flip_camera_ios, color: Colors.white,size: 28,))),
          //           ],
          //         ),
          //       ),
          //       SizedBox(height: 5),
          //       Text('Hold for Video, tap for photo', style: GoogleFonts.poppins(color: Colors.grey, ),textAlign: TextAlign.center,)
          //     ],
          //   ),
          // ),
         );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    if (_appLifecycleState == AppLifecycleState.resumed) {
      // starts camera and then loads the tensorflow model
    initializeCamera();
    }
  }


  void takePicture(BuildContext context)async{
    XFile path = await _cameraController!.takePicture();
    // Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraViewPage(path: path.path)));


  }

}
