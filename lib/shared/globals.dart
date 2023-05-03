import 'package:ai_trainer/views/pages/home_page.dart';
import 'package:ai_trainer/views/pages/info_page.dart';
import 'package:ai_trainer/views/pages/my_profile.dart';
import 'package:flutter/material.dart';

enum LoginError {success, userNotExist, errorDbConnection}

List<Map<String,dynamic>> menu = [
  {
    "icon": Icons.home,
    "title": "Home",
    "screen": HomePage(),
  },
  {
    "icon": Icons.person,
    "title": "My Profile",
    "screen": MyProfile(),

  },
  {
    "icon": Icons.info,
    "title": "Information",
    "screen": Info(),

  },
];

class Global {

  static const orange = Colors.orange;
  static const lightWhite = Colors.white70;
  static const black = Colors.black;
  static const lightBlack = Colors.black87;
  static const white = Colors.white;
  static const errorColor = Colors.red;

}
