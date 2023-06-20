import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/pages/home_page.dart';
import 'package:ai_trainer/views/pages/info_page.dart';
import 'package:ai_trainer/views/pages/my_profile.dart';
import 'package:ai_trainer/views/pages/workout_page.dart';
import 'package:flutter/material.dart';
import '../views/pages/change_level.dart';

List<Map<String,dynamic>> menu = [
  {
    "icon": Icons.home,
    "title": "Home",
    "screen": (MyUser user)=> HomePage(user: user,),
  },
  {
    "icon": Icons.person,
    "title": "My Profile",
    "screen": (MyUser user) => MyProfile(user: user,),

  },
  {
    "icon": Icons.info,
    "title": "Information",
    "screen": (MyUser user) => Info(user: user,),
  },
  {
    "icon": Icons.sports_gymnastics,
    "title": "Start Workout",
    "screen": (MyUser user) => WorkoutPage(user: user),
  },
  {
    "icon": Icons.swap_calls_outlined,
    "title": "Change My Level",
    "screen": (MyUser user) => ChangeLevelPage(user: user),
  },
];

class AppColors {

  static const orange = Colors.orange;
  static const yellow = Colors.yellowAccent;
  static const lightWhite = Colors.white70;
  static const black = Colors.black;
  static const lightBlack = Colors.black87;
  static const white = Colors.white;
  static const errorColor = Colors.red;
  static const successColor = Colors.green;

  static const white10 = Colors.white10;
  static const redAccent = Colors.redAccent;
  static const black54 = Colors.black54;
  static const white54 = Colors.white54;
  static const orangeAccent = Colors.orangeAccent;
  static const grey = Colors.grey;


}
