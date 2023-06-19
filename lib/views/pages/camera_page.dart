import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:teachable/teachable.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/excercise_count.dart';

//import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
//import '../../shared/globals.dart';

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
  bool isLoading = false;




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

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     initCamera();
  //   }
  // }

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
      print(e.toString());
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
        currentExercise = exercise;
        if (currentExercise == 'Nothing') {
          isLoading = false;
          return;
        }
        if (score > 0.99) {
          repetitions++;
          isLoading = false;
          return;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String exe = widget.exercise.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    String temp = "lib/assets/$exe.html";
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise)),
      body: isCameraInitialized ?
      Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Teachable(
                  path: temp,
                  results: (res) {
                    processResult(res, exe);
                  },
                ),
              ),
            ],
          ),
          // FlipCameraButton(flip),
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
      )
      :
      const SizedBox(
        height: 13,
      ),
    );
  }
}
