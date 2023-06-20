import 'package:ai_trainer/shared/globals.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: AppColors.errorColor,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(String? text, {int duration = 3000}) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: AppColors.successColor, // Assuming you have a success color defined in 'AppColors'
      duration: Duration(milliseconds: duration),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}





