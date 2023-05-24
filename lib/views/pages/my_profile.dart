import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("my profile"),
    );
  }
}
