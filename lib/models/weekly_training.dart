
class WeeklyTraining {
  final String user_id;
  final String exercise_id;
  bool is_done;

  WeeklyTraining({required this.user_id, required this.exercise_id, required this.is_done});

  Map<String, dynamic> toJson() =>
      {
        'user_id': user_id,
        'exercise_id': exercise_id,
        'is_done': is_done,
      };

  static WeeklyTraining fromJson(Map<String, dynamic> json) =>
      WeeklyTraining(
        user_id: json['user_id'],
        exercise_id: json['exercise_id'],
        is_done: json['is_done'],
      );
}