import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class SignInButtonWidget extends StatelessWidget {
  final String title;
  final Future Function() onTap;
  //final dynamic controllers;

  const SignInButtonWidget({super.key,
   required this.title,
    required this.onTap,
    //this.controllers,
});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(10),
          border: const Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: () async => onTap(),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.black,
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
