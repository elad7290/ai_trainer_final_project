import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/views/pages/video_page.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: change to video and stuff about workout
    return VideoPage(exercise: Exercise(name: 'hi', tools: 'tools', videoURL: 'https://firebasestorage.googleapis.com/v0/b/ai-trainer-db.appspot.com/o/training_videos%2Fpexels-artem-podrez-5752729-3840x2160-30fps.mp4?alt=media&token=3bfa0fa9-730a-4d58-8b9f-a599f35b2a89'));
  }
}
