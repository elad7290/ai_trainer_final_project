import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/globals.dart';

Widget ExerciseCount(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
    ),
  );
}
