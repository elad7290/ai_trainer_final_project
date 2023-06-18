import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:teachable/teachable.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {

  final String exercise;
  const CameraScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();

}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  late CameraController camera_controller;
  bool isCameraInitialized = false;
  int direction = 1;
  int repetitions = 0;
  int sets = 0;
  String currentExercise = "";
  String confidence = "";
  bool isLoading = false;
  int counter = 0; // Counter variable


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    camera_controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  void initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
    cameras = await availableCameras();
    camera_controller = CameraController(
      cameras[direction],
      ResolutionPreset.low,
      enableAudio: false,
    );
    await camera_controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraInitialized = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void flip() {
    setState(() {
      direction = direction == 0 ? 1 : 0;
      initCamera();
    });
  }

  void processResult(String result, String exe) {

    if (isLoading) {
      return;
    }

    var decodedResult = jsonDecode(result);
    decodedResult.forEach((exercise, score) {
      setState(() {
        Map<String, String> exerciseMap = {
          'Push ups': 'Push ups',
          'Crunches' : 'Crunches',
          'Squats' : 'Squats',
          'Lateral raises' : 'Lateral Raises',
          'Bench dips' : 'Bench dips',
          'Dips' : 'Dips',
          'Bicep curls' : 'Bicep curls',
          'Pull ups' : 'Pull ups',
          'Nothing': 'Nothing',
        };

        currentExercise = exerciseMap[exercise]!;
        confidence = (score * 100.0).toStringAsFixed(2);
        if(currentExercise == 'Nothing'){
          isLoading = false;
          return;
        }
      if (score > 0.99) {
          counter++;
          print(counter);
          isLoading = false;
          return;
        }
      });
    });
  }

  // void startProcessing() {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    String exe = widget.exercise.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    String temp = "lib/assets/$exe.html";
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise)),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Teachable(
                      path: temp,
                      results: (res) {
                        processResult(res,exe);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: isLoading
                  ? CircularProgressIndicator()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confidence: $confidence%",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: incrementCounter,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          counter.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}