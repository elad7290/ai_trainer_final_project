import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/plan_model.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/pages/video_page.dart';
import 'package:flutter/material.dart';

import '../../controllers/plan_controller.dart';

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
      isPlanInitialized = true;
    });
  }

  void nevigateToVideoPage(Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPage(exercise: exercise)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isPlanInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Workout'),
        ),
        body: ListView.builder(
          itemCount: plan!.exercises.length,
          itemBuilder: (BuildContext context, int index) {
            Exercise exercise = plan!.exercises[index];
            return ListTile(
              title: Text(exercise.name),
              onTap: () => nevigateToVideoPage(exercise),
            );
          },
        ),
      );
    }
    else{
      return const SizedBox();
    }

    return VideoPage(exercise: Exercise(name: 'hi', tools: 'tools', videoURL: 'https://firebasestorage.googleapis.com/v0/b/ai-trainer-db.appspot.com/o/training_videos%2Fpexels-artem-podrez-5752729-3840x2160-30fps.mp4?alt=media&token=3bfa0fa9-730a-4d58-8b9f-a599f35b2a89'));
  }
}
