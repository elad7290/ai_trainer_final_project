import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import '../../models/exercise_model.dart';
import '../widgets/excercise_count.dart';
import 'package:teachable/teachable.dart';
import 'package:permission_handler/permission_handler.dart';


class CameraScreen extends StatefulWidget {
  // Exercise exercise;
  // late String exe = "";
  final String exercise;


  const CameraScreen({Key? key, required this.exercise}) : super(key: key);


  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  late CameraController camera_controller;
  bool isCameraInitialized = false;
  int direction = 1;
  int repetitions = 0;
  int sets = 0;

  String currentExercise = "";
  String confidence = "";
  bool isLoading = false; // Added loading indicator

  Map<String, String> pushups = {
    'Push ups': 'Push ups',
    'Nothing': 'Nothing',
  };

  Map<String, String> crunches = {
    'Crunches': 'Crunches',
    'Nothing': 'Nothing',
  };

  // final String chosen_exercise = "";

  // _CameraScreenState(String chosenExercise){
  //   chosenExercise = chosen_exercise;
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
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
      ResolutionPreset.high,
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

  void processResult(String result) {
    var decodedResult = jsonDecode(result);
    decodedResult.forEach((exercise, score) {
      if (score > 0.9) {
        setState(() {
          currentExercise = pushups[exercise]!;
          confidence = (score * 100.0).toStringAsFixed(2);
          isLoading = false; // Set isLoading to false when the result is obtained
        });
        return;
      }
    });
  }

  void startProcessing() {
    setState(() {
      isLoading = true; // Set isLoading to true when processing starts
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.exercise);
   // String exe = widget.exe.name;
    return Scaffold(
      appBar: AppBar(title: const Text("Pose classifier")),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Teachable(
                      path: "lib/assets/index.html",
                      results: (res) {
                        processResult(res);
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
              child: isLoading // Conditional rendering based on isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Exercise: $currentExercise",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Confidence: $confidence%",
                    style: const TextStyle(
                      color: Colors.white,
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
