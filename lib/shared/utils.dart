import 'package:ai_trainer/shared/globals.dart';
import 'package:flutter/material.dart';

class Utils {

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text){
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Global.errorColor,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

}