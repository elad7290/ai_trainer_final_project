import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/pages/video_page.dart';
import 'package:flutter/material.dart';
import '../../controllers/exercise_controller.dart';
import '../../shared/globals.dart';
import 'fitness_questionnaire.dart';


class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Exercise>? exercises;
  bool isExercisesInitialized = false;

  @override
  void initState() {
    initExercises();
    super.initState();
  }

  void initExercises() async {
    exercises = await getExercises();
    setState(() {
      if (exercises != null){
        isExercisesInitialized = true;
      }
    });
  }

  void navigateToVideoPage(Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPage(exercise: exercise)),
    );
  }

  void navigateToQuestionnaire() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FitnessQuestionnaire(user: widget.user, levelUpdated: levelUpdated,)),
    );
  }

  void levelUpdated() {
    initExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Weekly Workout',
            textAlign: TextAlign.center,
          style: TextStyle(color: Global.orange),
        ),
        centerTitle: true,
      ),
      body: widget.user.level <= 0 ?
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Text(
              "To determine your level please fill out a questionnaire",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              width: 250,
              child: ElevatedButton(
                onPressed: navigateToQuestionnaire,
                child: Row(
                    children: const [
                      Text('Fill The Questionnaire', style: TextStyle(fontSize: 16,)),
                      Icon(Icons.arrow_right),
                    ]
                ),
              ),
            ),
          ],
        ),
      )
      :
      isExercisesInitialized ?
      ListView.builder(
        itemCount: exercises!.length,
        itemBuilder: (BuildContext context, int index) {
          Exercise exercise = exercises![index];
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
      :
      const SizedBox(),
    );
  }
}
