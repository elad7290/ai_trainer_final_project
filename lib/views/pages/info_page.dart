import 'package:ai_trainer/models/user_model.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("info"),
    );
  }
}
