
class Plan {
  final int level;
  final int sets;
  final String information;
  final List<String> exercises;


  Plan({required this.level, required this.sets,
    required this.information, required this.exercises});

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'sets': sets,
        'information': information,
        'exercises': exercises,
      };

  static Plan fromJson(Map<String, dynamic> json) =>
     Plan(
      level: json['level'],
      sets: json['sets'],
      information: json['information'],
      exercises: [for (var ex in json['exercises']) ex.toString()],
    );

}

