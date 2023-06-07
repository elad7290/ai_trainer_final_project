import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/globals.dart';

Widget ExcerciseCount(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
    ),
  );
}
