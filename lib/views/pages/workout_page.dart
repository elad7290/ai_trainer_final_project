import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/plan_model.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/pages/video_page.dart';
import 'package:flutter/material.dart';

import '../../controllers/plan_controller.dart';
import '../../shared/globals.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Plan? plan;
  bool isPlanInitialized = false;

  @override
  void initState() {
    initPlan();
    super.initState();
  }

  void initPlan() async {
    plan = await getPlan(widget.user);
    setState(() {
      if (plan != null){
        isPlanInitialized = true;
      }
    });
  }

  void navigateToVideoPage(Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPage(exercise: exercise)),
    );
  }


  //TODO: if user level = 0 then navigate to questionaire
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
                'Weekly Workout',
                textAlign: TextAlign.center,
              style: TextStyle(color: Global.orange),
            ),
            centerTitle: true,
          ),
          body: isPlanInitialized ?
          ListView.builder(
            itemCount: plan!.exercises.length,
            itemBuilder: (BuildContext context, int index) {
              Exercise exercise = plan!.exercises[index];
              return GestureDetector(
                onTap: () => navigateToVideoPage(exercise),
                child: Container(

                  child: ListTile(
                    title: Text(
                      exercise.name,
                      style: TextStyle(fontSize: 22.0),
                      textAlign: TextAlign.center,
                    ),
                    selectedTileColor: Global.orange,
                  ),
                ),
              );
            },
          )
          : const SizedBox(),
        ),
      );
  }
}
