import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:teachable/teachable.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controllers/plan_controller.dart';
import '../../models/plan_model.dart';
import '../../shared/globals.dart';
import '../widgets/excercise_count.dart';
//import 'package:ai_trainer/views/widgets/flip_camera_button.dart';
//import '../../shared/globals.dart';

class CameraScreen extends StatefulWidget {
  final Exercise exercise;
  final MyUser user;
  const CameraScreen({Key? key, required this.exercise, required this.user}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  int direction = 1;
  int repetitions = 0;
  int sets = 0;
  String currentExercise = "";
  Plan? plan;
  bool isPlanInitialized = false;

  @override
  void initState() {
    initPlan();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void initPlan() async {
    plan = await getPlan(widget.user);
    setState(() {
      if (plan != null) {
        isPlanInitialized = true;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     initCamera();
  //   }
  // }

  void processResult(String result, String exe) {
    var decodedResult = jsonDecode(result);
    decodedResult.forEach((exercise, score) {
      setState(() {
        currentExercise = exercise;
        if (currentExercise == 'Nothing') {
          return;
        }
        if (score > 0.99) {
          if(sets<=plan!.sets){
            if (repetitions >= widget.exercise.repetitions) {
              sets++;
              repetitions = 0;
            }
            else{
              repetitions++;
            }
          }
          else{
            //TODO: done this page
          }
          return;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String exe = widget.exercise.name.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    String temp = "lib/assets/$exe.html";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exercise.name,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.orange),
        ),
        centerTitle: true,
      ),
      body: isPlanInitialized ?
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
                        ExcerciseCount("Repetitions:   " +
                            repetitions.toString() +
                            " / " + widget.exercise.repetitions.toString()),
                        SizedBox(
                          height: 10,
                        ),
                        ExcerciseCount("Sets:   " + sets.toString() + " / " + plan!.sets.toString()),
                      ],
                    ),
                  ),
                )
              ],
            )
          :
          SizedBox(height: 15,)
    );
  }
}
