import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:montion_verse/ui/views/front_camera_screen/another_camera.dart';
import 'package:montion_verse/ui/views/front_camera_screen/bounding_box.dart';

class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  LiveFeed(this.cameras);
  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
 List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  double? h,x ,w, y;
  String? label;
  initCameras() async {

  }
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/labelmap.txt",
        // isAsset: true,
        // numThreads: 1,
        // useGpuDelegate: false
    );
  }
  /*
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
    print("Recognitionsssssss: $_recognitions");
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Time Object Detection"),
      ),
      body: Stack(
        children: <Widget>[
          CameraFeed(widget.cameras, setRecognitions),

          _recognitions == null ? Container(color: Colors.green,):BoundingBox(
            results: _recognitions ?? [],
            previewH: math.max(_imageHeight, _imageWidth),
            previewW: math.min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,




          ),
        ],
      ),
    );
  }
}