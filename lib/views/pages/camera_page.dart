import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import '../widgets/excercise_count.dart';
import 'package:teachable/teachable.dart';
import 'package:permission_handler/permission_handler.dart';


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

  String pose = "";

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
    return Scaffold(
        appBar: AppBar(title: Text("Pose classifier")),
        body: Stack(
          children: [
            Container(
                child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: Teachable(
                    path: "lib/assets/index.html",
                    results: (res) {
                      var resp = jsonDecode(res);
                      // print("The values are ${}");
                      setState(() {
                        pose = (resp['Tree Pose'] * 100.0).toString();
                      });
                    },
                  ),
                ),
              ),
            ])),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "TREE POSE test",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            pose,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
