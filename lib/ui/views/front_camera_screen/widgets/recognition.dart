import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montion_verse/services/tensorflow-service.dart';

class Recognition extends StatefulWidget {
  Recognition({Key? key, required this.ready}) : super(key: key);

  // indicates if the animation is finished to start streaming (for better performance)
  final bool? ready;

  @override
  _RecognitionState createState() => _RecognitionState();
}

enum SubscriptionState { Active, Done }

class _RecognitionState extends State<Recognition> {
  // current list of recognition
  List<dynamic> _currentRecognition = [];

  // listens the changes in tensorflow recognitions
  StreamSubscription? _streamSubscription;

  // tensorflow service injection
  final TensorflowService _tensorflowService = TensorflowService();

  @override
  void initState() {
    super.initState();

    // starts the streaming to tensorflow results
    _startRecognitionStreaming();
  }

  _startRecognitionStreaming() {
    _streamSubscription ??= _tensorflowService.recognitionStream.listen((recognition) {
        if (recognition != null) {
          // rebuilds the screen with the new recognitions
          setState(() {
            _currentRecognition = recognition;
          });
        } else {
          _currentRecognition = [];
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.grey.shade500,
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: widget.ready!
                      ? <Widget>[
                          // shows recognition title
                          _titleWidget(),

                          // shows recognitions list
                          _contentWidget(),
                        ]
                      : <Widget>[],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 10),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Recognitions",
            style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _contentWidget() {
    var width = MediaQuery.of(context).size.width;
    var padding = 20.0;
    var labelWidth = 150.0;
    var labelConfidence = 30.0;
    var barWidth = width - labelWidth - labelConfidence - padding * 2.0;

    if (_currentRecognition.isNotEmpty) {
      return SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: _currentRecognition.length,
          itemBuilder: (context, index) {
            if (_currentRecognition.length > index) {
              return SizedBox(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      width: labelWidth,
                      child: Text(
                        _currentRecognition[index]['label'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: barWidth,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        value: _currentRecognition[index]['confidence'],
                      ),
                    ),
                    SizedBox(
                      width: labelConfidence,
                      child: Text(
                        (_currentRecognition[index]['confidence'] * 100).toStringAsFixed(0) + '%',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
