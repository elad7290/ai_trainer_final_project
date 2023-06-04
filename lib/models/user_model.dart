import 'package:ai_trainer/models/progress_point.dart';
import 'package:intl/intl.dart';

class MyUser {
  final String name;
  final String email;
  final DateTime birthDate;
  int level;
  final double weight;
  final double height;
  List<ProgressPoint> progress_points;

  //final map<int,double>
  //final Imag pic

  MyUser({required this.name,
    required this.email,
    required this.birthDate,
    required this.level,
    required this.weight,
    required this.height,
    required this.progress_points});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'birthDate': DateFormat('yyyy-MM-dd').format(birthDate).toString(),
        'level': level,
        'weight': weight,
        'height': height,
        'percents': progress_points.map((point) => point.percent).toList(),
      };

  static MyUser fromJson(Map<String, dynamic> json) =>
      MyUser(
          name: json['name'],
          email: json['email'],
          birthDate: DateTime.parse(json['birthDate']),
          level: json['level'],
          weight: json['weight'],
          height: json['height'],
          progress_points: List<ProgressPoint>.from(
              json['percents']
                  .asMap()
                  .entries
                  .map((e) {
                int week = e.key;
                double percent = e.value.toDouble();
                return ProgressPoint(week: week, percent: percent);
              })),
      );


}
