import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import '../widgets/excercise_count.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraImage? cameraImage;
  var threshold = 0.8;
  late List<CameraDescription> cameras;
  late CameraController camera_controller;
  bool isCameraInitialized = false;
  int direction = 1;
  int repetitions = 0;
  int sets = 0;
  bool isProcessing = false; // Flag to track inference status
  int inferenceDelay = 1000; // Delay in milliseconds (1 second)

  Timer? timer;
  var latestPrediction = '';

  void initCamera() async {
    cameras = await availableCameras();
    camera_controller = CameraController(cameras[direction], ResolutionPreset.high, enableAudio: false);
    await camera_controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraInitialized = true;
        camera_controller.startImageStream((imageStream) {
          cameraImage = imageStream;
        });
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

  @override
  void initState() {
    initCamera();
    loadmodel();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!isProcessing) {
        runModel();
      }
    });
  }

  @override
  void dispose() {
    camera_controller.dispose();
    timer?.cancel(); // Cancel the timer
    super.dispose();
  }

  runModel() async {
    if (cameraImage != null && !isProcessing) {
      setState(() {
        isProcessing = true;
      });

      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      if (predictions != null && predictions.isNotEmpty) {
        setState(() {
          latestPrediction = predictions[0]['label'];
          var confidence = predictions[0]['confidence'];

      if (confidence > 0.85) {
        setState(() {
          latestPrediction = predictions[0]['label'];
        });
      } else {
        setState(() {
          latestPrediction = 'undetected';
        });
      }
          print("Latest Prediction: $latestPrediction");
        });
      }

      setState(() {
        isProcessing = false;
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    if (isCameraInitialized && camera_controller.value.isInitialized) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                border: Border.all(
                  color: latestPrediction != 'undetected' ? Colors.green : Colors.red,
                  width: 4,
                ),
              ),
                child: CameraPreview(camera_controller),
              ),
              FlipCameraButton(flip),
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      ExcerciseCount("Repetitions:   " + repetitions.toString() + " / 30"),
                      SizedBox(height: 10,),
                      ExcerciseCount("Sets:   " + sets.toString() + " / 3"),
                      SizedBox(height: 10,),
                      ExcerciseCount("Current Exercise:   " + latestPrediction),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
