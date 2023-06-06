import 'package:flutter/material.dart';

import '../../shared/globals.dart';

class InfoCard extends StatelessWidget {

  const InfoCard({
    Key? key,
    required this.name,
    required this.email,
    required this.image,
  }) : super(key: key);

  final String name,email;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: image != null ? NetworkImage(image!) : null,
        backgroundColor: Global.orange,
        child: image == null ? Icon(
          Icons.person,
          color: Global.lightWhite ,
        ) : null,
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
