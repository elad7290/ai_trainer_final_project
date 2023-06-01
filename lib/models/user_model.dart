
import 'package:intl/intl.dart';

class MyUser {
  final String name;
  final String email;
  final DateTime birthDate;
  int level;
  final double weight;
  final double height;

  //final map<int,double>
  //final Imag pic


  MyUser({required this.name,required this.email, required this.birthDate, required this.level,
    required this.weight, required this.height });

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'birthDate': DateFormat('yyyy-MM-dd').format(birthDate).toString(),
        'level': level,
        'weight': weight,
        'height': height,
      };

  static MyUser fromJson(Map<String, dynamic> json) =>
      MyUser(
        name: json['name'],
        email: json['email'],
        birthDate: DateTime.parse(json['birthDate']),
        level: json['level'],
        weight: json['weight'],
        height: json['height'],
      );
}

