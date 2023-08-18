// Copyright (c) 2022 Kodeco LLC

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical
// or instructional purposes related to programming, coding,
// application development, or information technology.  Permission for such use,
// copying, modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// import 'dart:math';
// import 'dart:async';
// import 'dart:ui';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image/image.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
//
// import 'classifier_category.dart';
// import 'classifier_model.dart';
//
// typedef ClassifierLabels = List<String>;
//
// class Classifier {
//   static bool _modelLoaded = false;
//   static CameraController? _cameraController;
//   static CameraController? get cameraController => _cameraController;
//
//   final ClassifierLabels _labels;
//   final ClassifierModel _model;
//   static StreamController<List<dynamic>> _recognitionController = StreamController();
//   Stream get recognitionStream => _recognitionController.stream;
//
//
//   Classifier._({
//     required ClassifierLabels labels,
//     required ClassifierModel model,
//   })  : _labels = labels,
//         _model = model;
//
//    static Future<Classifier?> loadWith({
//     required String labelsFileName,
//     required String modelFileName,
//   }) async {
//     try {
//       _recognitionController.add([]);
//
//       final labels = await _loadLabels(labelsFileName);
//       final model = await _loadModel(modelFileName);
//       _modelLoaded = true;
//       return Classifier._(labels: labels, model: model);
//
//     } catch (e) {
//       debugPrint('Can\'t initialize Classifier: ${e.toString()}');
//       if (e is Error) {
//         debugPrintStack(stackTrace: e.stackTrace);
//       }
//       return null;
//     }
//   }
//
//   static Future<ClassifierModel> _loadModel(String modelFileName) async {
//     final interpreter = await Interpreter.fromAsset(modelFileName);
//
//     // Get input and output shape from the model
//     final inputShape = interpreter.getInputTensor(0).shape;
//     final outputShape = interpreter.getOutputTensor(0).shape;
//
//     debugPrint('Input shape: $inputShape');
//     debugPrint('Output shape: $outputShape');
//
//     // Get input and output type from the model
//     final inputType = interpreter.getInputTensor(0).type;
//     final outputType = interpreter.getOutputTensor(0).type;
//
//     debugPrint('Input type: $inputType');
//     debugPrint('Output type: $outputType');
//
//     return ClassifierModel(
//       interpreter: interpreter,
//       inputShape: inputShape,
//       outputShape: outputShape,
//       inputType: inputType,
//       outputType: outputType,
//     );
//   }
//
//   static Future<ClassifierLabels> _loadLabels(String labelsFileName) async {
//     final rawLabels = await FileUtil.loadLabels(labelsFileName);
//
//     // Remove the index number from the label
//     final labels = rawLabels
//         .map((label) => label.substring(label.indexOf(' ')).trim())
//         .toList();
//
//     debugPrint('Labels: $labels');
//     return labels;
//   }
//
//   void close() {
//     _model.interpreter.close();
//   }
//   static Image convertYUV420ToImage(CameraImage cameraImage) {
//     final int width = cameraImage.width;
//     final int height = cameraImage.height;
//
//     final int uvRowStride = cameraImage.planes[1].bytesPerRow;
//     final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;
//
//     final image =Image(width, height);
//
//     for (int w = 0; w < width; w++) {
//       for (int h = 0; h < height; h++) {
//         final int uvIndex =
//             uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
//         final int index = h * width + w;
//
//         final y = cameraImage.planes[0].bytes[index];
//         final u = cameraImage.planes[1].bytes[uvIndex];
//         final v = cameraImage.planes[2].bytes[uvIndex];
//
//         image.data[index] = Classifier.yuv2rgb(y, u, v);
//       }
//     }
//     return image;
//   }
//
//   /// Convert a single YUV pixel to RGB
//   static int yuv2rgb(int y, int u, int v) {
//     // Convert yuv pixel to rgb
//     int r = (y + v * 1436 / 1024 - 179).round();
//     int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
//     int b = (y + u * 1814 / 1024 - 227).round();
//
//     // Clipping RGB values to be inside boundaries [ 0 , 255 ]
//     r = r.clamp(0, 255);
//     g = g.clamp(0, 255);
//     b = b.clamp(0, 255);
//
//     return 0xff000000 |
//     ((b << 16) & 0xff0000) |
//     ((g << 8) & 0xff00) |
//     (r & 0xff);
//   }
//
//   ClassifierCategory predict(Image image) {
//     debugPrint(
//       'Image: ${image.width}x${image.height}, '
//       'size: ${image.length} bytes',
//     );
//
//     // Load the image and convert it to TensorImage for TensorFlow Input
//     final inputImage = _preProcessInput(image);
//
//     debugPrint(
//       'Pre-processed image: ${inputImage.width}x${image.height}, '
//       'size: ${inputImage.buffer.lengthInBytes} bytes',
//     );
//
//     // Define the output buffer
//     final outputBuffer = TensorBuffer.createFixedSize(
//       _model.outputShape,
//       _model.outputType,
//     );
//
//     // Run inference
//   _model.interpreter.run(inputImage.buffer, outputBuffer.buffer);
//
//     debugPrint('OutputBuffer: ${outputBuffer.getDoubleList()}');
//
//     // Post Process the outputBuffer
//     final resultCategories = _postProcessOutput(outputBuffer);
//     final topResult = resultCategories.first;
//
//     if (resultCategories.isNotEmpty) {
//       print(resultCategories[0].toString());
//       if (_recognitionController.isClosed) {
//         // restart if was closed
//         _recognitionController = StreamController();
//       }
//       // notify to listeners
//       _recognitionController.add(resultCategories);
//     }
//
//     return topResult;
//   }
//   Future<void> stopRecognitions() async {
//     if (!_recognitionController.isClosed) {
//       _recognitionController.add([]);
//       _recognitionController.close();
//     }
//   }
//
//   void dispose() async {
//     _recognitionController.close();
//   }
//
//   List<ClassifierCategory> _postProcessOutput(TensorBuffer outputBuffer) {
//     final probabilityProcessor = TensorProcessorBuilder().build();
//
//     probabilityProcessor.process(outputBuffer);
//
//     final labelledResult = TensorLabel.fromList(_labels, outputBuffer);
//
//     final categoryList = <ClassifierCategory>[];
//     labelledResult.getMapWithFloatValue().forEach((key, value) {
//       final category = ClassifierCategory(key, value);
//       categoryList.add(category);
//       debugPrint('label: ${category.label}, score: ${category.score}');
//     });
//     categoryList.sort((a, b) => (b.score > a.score ? 1 : -1));
//
//     return categoryList;
//   }
//
//   TensorImage _preProcessInput(Image image) {
//     // #1
//     final inputTensor = TensorImage(_model.inputType);
//     inputTensor.loadImage(image);
//
//     // #2
//     final minLength = min(inputTensor.height, inputTensor.width);
//     final cropOp = ResizeWithCropOrPadOp(minLength, minLength);
//
//     // #3
//     final shapeLength = _model.inputShape[1];
//     final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.BILINEAR);
//
//     // #4
//     final normalizeOp = NormalizeOp(127.5, 127.5);
//
//     // #5
//     final imageProcessor = ImageProcessorBuilder()
//         .add(cropOp)
//         .add(resizeOp)
//         .add(normalizeOp)
//         .build();
//
//     imageProcessor.process(inputTensor);
//
//     // #6
//     return inputTensor;
//   }
// }
