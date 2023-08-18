
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:montion_verse/services/camera-service.dart';
import 'package:montion_verse/services/tensorflow-service.dart';
import 'package:montion_verse/ui/views/front_camera_screen/widgets/recognition.dart';
import 'camera-header.dart';
import 'camera-screen.dart';

class Home extends StatefulWidget {
  final CameraDescription? camera;

  const Home({
    Key? key,
    @required this.camera,
  }) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin, WidgetsBindingObserver {
  // Services injection
  TensorflowService _tensorflowService = TensorflowService();
  CameraService _cameraService = CameraService();

  // future for camera initialization
  Future<void>? _initializeControllerFuture;

  late AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // starts camera and then loads the tensorflow model
    startUp();
  }

  Future startUp() async {
    if (!mounted) {
      return;
    }
    if (_initializeControllerFuture == null) {
      _initializeControllerFuture = _cameraService.startService(widget.camera!).then((value) async {
        await _tensorflowService.loadModel();
        startRecognitions();
      });
    } else {
      await _tensorflowService.loadModel();
      startRecognitions();
    }
  }

  startRecognitions() async {
    try {
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

  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [
          FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraScreen(
                controller: _cameraService.cameraController,
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
          Recognition(ready: true)
    ]  );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    if (_appLifecycleState == AppLifecycleState.resumed) {
      // starts camera and then loads the tensorflow model
      startUp();
    }else{
      stopRecognitions();
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraService.dispose();
    _tensorflowService.dispose();
    // stopRecognitions();
    _initializeControllerFuture = null;
    super.dispose();
  }
}
