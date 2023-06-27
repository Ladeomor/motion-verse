import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/ui/views/front_camera_screen/camera.dart';
List<CameraDescription>? cameras;

class FrontCamera extends StatefulWidget {
  const FrontCamera({Key? key}) : super(key: key);

  @override
  _FrontCameraState createState() => _FrontCameraState();
}

class _FrontCameraState extends State<FrontCamera> {

  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool flash = false;
  bool isFrontCamera = true;
  double transform = 0;
  bool isRecording = false;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);

    cameraValue= _cameraController!.initialize();

  }

  @override
  void dispose() {
    super.dispose();
    _cameraController!.dispose();
    cameraValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done)
                {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController!));
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 10.0,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          flash = !flash;
                        });

                      }, icon: Icon(flash?Icons.flash_on:Icons.flash_off, color: Colors.white,size: 28,),
                      ),
                      GestureDetector(
                          onLongPress: ()async{
                            // final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.mp4");
                            await _cameraController!.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: ()async{
                            XFile videopath =  await _cameraController!.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (builder) => VideoView(path: videopath.path,)));
                          },
                          onTap: (){
                            takePicture(context);
                          }, child: isRecording
                          ? const Icon(Icons.radio_button_on, color: Colors.red,size: 80,)
                          :
                      const Icon(Icons.panorama_fish_eye_rounded, color: Colors.white, size: 70,)),
                      IconButton(onPressed: ()async{

                        setState(() {
                          isFrontCamera = !isFrontCamera;
                          transform += pi;
                        });
                        int cameraPosition = isFrontCamera ? 0 : 1;
                        _cameraController = CameraController(
                            cameras![cameraPosition], ResolutionPreset.high);
                        cameraValue= _cameraController!.initialize();
                        //Transform.rotate rotates camera 180 degrees
                      }, icon: Transform.rotate(
                          angle: transform,
                          child: Icon(Icons.flip_camera_ios, color: Colors.white,size: 28,))),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text('Hold for Video, tap for photo', style: GoogleFonts.poppins(color: Colors.grey, ),textAlign: TextAlign.center,)
                    ],
                  ),
                )
              ],
            ),
    );
  }
  void takePicture(BuildContext context)async{
    XFile path = await _cameraController!.takePicture();
    // Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraViewPage(path: path.path)));


  }

}