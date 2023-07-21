
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  const BoundingBox(
      {Key? key,required this.results,
    required this.previewH,
    required this.previewW,
    required this.screenH,
    required this.screenW,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return results.first == null?Container(): Positioned(
      top: results.first['rect']['y']* 700,
      right: results.first['rect']['x']* 500,
      child: results.first == null ? Container():Container(
        width: results.first['rect']['w']* 100*MediaQuery.of(context).size.width/100 ,
        height: results.first['rect']['h']* 100*MediaQuery.of(context).size.height/100 ,
        decoration: BoxDecoration(
          // color: Colors.green,

          border: Border.all(color: Colors.green, width: 4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
                child: Text(results.first["detectedClass"] ?? '[]'),
            ),  ],
        ),
      ),
    );
  }
}


