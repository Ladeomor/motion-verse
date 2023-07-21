import 'dart:async';

import 'package:flutter/material.dart';

import 'package:montion_verse/ui/views/front_camera_screen/front_camera.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  bool loading = true;
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 2,
        ), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrontCamera();
  }


}
