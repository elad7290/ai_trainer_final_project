import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/globals.dart';

Widget FlipCameraButton(VoidCallback flip){
  return GestureDetector(
    onTap: flip,
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Global.yellow,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2,2),
                  blurRadius: 10
              )
            ]
        ),
        child: Center(
          child: Icon(Icons.flip_camera_ios_outlined, color: Colors.black54,),
        ),
      ),
    ),
  );
}