import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:teachable/teachable.dart';
import '../../controllers/exercise_controller.dart';
import '../../controllers/plan_controller.dart';
import '../../models/plan_model.dart';
import '../../shared/globals.dart';
import '../widgets/excercise_count.dart';

class CameraScreen extends StatefulWidget {
  final Exercise exercise;
  final MyUser user;
  final void Function() finished;
  const CameraScreen({Key? key, required this.exercise, required this.user, required this.finished}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  int repetitions = 0;
  int sets = 0;
  String currentExercise = "";
  Plan? plan;
  bool isPlanInitialized = false;
  bool isFinished = false;

  @override
  void initState() {
    initCamera();
    initPlan();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
    // cameras = await availableCameras();
    // camera_controller = CameraController(
    //   cameras[direction],
    //   ResolutionPreset.low,
    //   enableAudio: false,
    // );
    // await camera_controller.initialize().then((value) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {
    //     isCameraInitialized = true;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
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

  void processResult(String result, String exe) {
    var decodedResult = jsonDecode(result);
    decodedResult.forEach((exercise, score) {
      currentExercise = exercise;
      if (currentExercise == 'Nothing') {
        return;
      }
      if (score > 0.99) {
        if(sets < plan!.sets){
          if (repetitions > widget.exercise.repetitions) {
            setState(() {
              sets++;
              repetitions = 0;
            });
          }
          else{
            setState(() {
              repetitions++;
            });
          }
        }
        else{
          setState(() {
            isFinished = true;
          });
        }
        return;
      }
    });
  }

  Future finishedExercise() async {
    final navigator = Navigator.of(context);
    await finishExercise(widget.exercise.id);
    widget.finished();
    navigator.pop();
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        ExerciseCount("Repetitions:   $repetitions / ${widget.exercise.repetitions}"),
                        const SizedBox(
                          height: 10,
                        ),
                        ExerciseCount("Sets:   $sets / ${plan!.sets}"),
                      ],
                    ),
                  ),
                ),
                if (isFinished)
                  Center(
                    child: Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You completed the exercise Successfully!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: finishedExercise,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            )
          :
          const SizedBox(height: 15,),
    );
  }
}
