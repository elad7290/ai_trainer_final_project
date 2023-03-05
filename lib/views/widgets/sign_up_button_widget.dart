import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class SignUpButtonWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const SignUpButtonWidget({super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Global.black,
      child: Ink(
        decoration: BoxDecoration(
          color: Global.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Global.orange,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: onTap(),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color:Global.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
