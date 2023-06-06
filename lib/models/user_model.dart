import 'package:ai_trainer/models/progress_point.dart';
import 'package:intl/intl.dart';

class MyUser {
  String name;
  String email;
  DateTime birthDate;
  int level;
  double weight;
  double height;
  List<ProgressPoint> progress_points;
  String? profile_image;

  //final map<int,double>
  //final Imag pic

  MyUser(
      {required this.name,
      required this.email,
      required this.birthDate,
      required this.level,
      required this.weight,
      required this.height,
      required this.progress_points,
      this.profile_image});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthDate': DateFormat('dd-MM-yyyy').format(birthDate).toString(),
        'level': level,
        'weight': weight,
        'height': height,
        'percents': progress_points.map((point) => point.percent).toList(),
        'profile_image': profile_image,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
        name: json['name'],
        email: json['email'],
        birthDate: DateFormat('dd-MM-yyyy').parse(json['birthDate']),
        level: json['level'],
        weight: json['weight'],
        height: json['height'],
        profile_image: json['profile_image'],
        progress_points:
            List<ProgressPoint>.from(json['percents'].asMap().entries.map((e) {
          int week = e.key;
          double percent = e.value.toDouble();
          return ProgressPoint(week: week, percent: percent);
        })),
      );
}
