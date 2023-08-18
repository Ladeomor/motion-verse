import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

// singleton class used as a service
class TensorflowService {
  // singleton boilerplate
  static final TensorflowService _tensorflowService = TensorflowService._internal();

  factory TensorflowService() {
    return _tensorflowService;
  }
  // singleton boilerplate
  TensorflowService._internal();

  StreamController<List<dynamic>> _recognitionController = StreamController();
  Stream get recognitionStream => _recognitionController.stream;

  bool _modelLoaded = false;

  Future<void> loadModel() async {
    try {
     _recognitionController.add([]);
      await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/label_new.txt",
      );
      _modelLoaded = true;
    } catch (e) {
      print('error loading model');
      print(e);
    }
  }

  Future<void> runModel(CameraImage? img) async {
    if (_modelLoaded) {
      List? recognitions = await Tflite.runModelOnFrame(
        bytesList: img!.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        imageHeight: img.height,
        imageWidth: img.width,
        numResults: 3,
        imageMean: 127.5,   // defaults to 127.5
        imageStd: 127.5,    // defaults to 127.5
        // rotation: 90,       // defaults to 90, Android only
        threshold: 0.1,
          asynch: true        // defaults to true

      );
      // shows recognitions on screen
      if (recognitions!.isNotEmpty) {
        print(recognitions[0].toString());
        print('Converted Imageee height: ${img.height}');

        if (_recognitionController.isClosed) {
          // restart if was closed
          _recognitionController = StreamController();
        }
        // notify to listeners
        _recognitionController.add(recognitions);
      }
    }
  }

  Future<void> stopRecognitions() async {
    if (!_recognitionController.isClosed) {
      _recognitionController.add([]);
      _recognitionController.close();
    }
  }

  void dispose() async {
    _recognitionController.close();
  }
}
