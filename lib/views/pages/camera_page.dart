import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

import '../widgets/excercise_count.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraImage? cameraImage;
  String output = '';

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
        camera_controller.startImageStream((imageStream) {
          cameraImage = imageStream;
          runModel();
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
  }

  @override
  void dispose() {
    camera_controller.dispose();
    super.dispose();
  }

  runModel()async{
    if(cameraImage!=null) {
      var predictions = await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
       }).toList(),
       imageHeight: cameraImage!.height,
       imageWidth: cameraImage!.width,
       imageMean: 127.5,
       imageStd: 127.5,
       rotation: 90,
       numResults: 2,
       threshold: 0.1,
       asynch: true);
       predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
       });
       
  }
  }
  loadmodel()async{
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
                      SizedBox(height:10,),
                      ExcerciseCount("Current Excercise:   " + output),

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