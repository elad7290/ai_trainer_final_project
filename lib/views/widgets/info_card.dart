import 'package:flutter/material.dart';

import '../../shared/globals.dart';

class InfoCard extends StatelessWidget {

  const InfoCard({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name,email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Global.orange,
        child: Icon(
          Icons.person,
          color: Global.lightWhite ,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
            color: Global.lightWhite
        ),
      ),
      subtitle: Text(email,
        style: TextStyle(color: Global.lightWhite),
      ),
    );
  }
}
