import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../widgets/excercise_count.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController camera_controller;
  bool isCameraInitialized = false;
  int direction = 1;

  int repetitions = 0;
  int sets = 0;

  void initCamera() async {
    cameras = await availableCameras();
    camera_controller = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
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

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    camera_controller.dispose();
    super.dispose();
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
                  child: CameraPreview(camera_controller)),
              FlipCameraButton(flip),
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      //TODO: take sets and rep from DB
                      ExcerciseCount("Repetitions:   " + repetitions.toString() + " / 30"),
                      SizedBox(height: 10,),
                      ExcerciseCount("Sets:   " + sets.toString() + " / 3"),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
