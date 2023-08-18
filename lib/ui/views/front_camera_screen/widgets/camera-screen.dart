import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key, required this.controller}) : super(key: key);
  final CameraController? controller;
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    // return AspectRatio(
    //   aspectRatio: MediaQuery.of(context).size.aspectRatio,
    //   child: SizedBox(
    //     width: size,
    //     height: size / widget.controller!.value.aspectRatio,
        return CameraPreview(widget.controller!);
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
