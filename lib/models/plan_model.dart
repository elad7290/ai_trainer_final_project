import 'package:ai_trainer/models/exercise_model.dart';

import '../controllers/exercise_controller.dart';

class Plan {
  final int level;
  final int repetitions;
  final int sets;
  final String information;
  final List<Exercise> exercises;


  Plan({required this.level, required this.repetitions, required this.sets,
    required this.information, required this.exercises});

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'repetitions': repetitions,
        'sets': sets,
        'information': information,
        'exercises': exercises.map((data) => data.toJson()).toList(),
      };

  static Future<Plan> fromJson(Map<String, dynamic> json) async{
    var exercises = await getExercisesByRef(json['exercises']);
    return Plan(
      level: json['level'],
      repetitions: json['repetitions'],
      sets: json['sets'],
      information: json['information'],
      exercises: exercises,
    );
  }

}

