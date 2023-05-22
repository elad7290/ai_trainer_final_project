import 'package:ai_trainer/models/exercise_model.dart';

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

  static Plan fromJson(Map<String, dynamic> json) =>
      Plan(
        level: json['level'],
        repetitions: json['repetitions'],
        sets: json['sets'],
        information: json['information'],
        exercises: json['exercises'].map((data)=>Exercise.fromJson(data)).toList(),
      );
}

