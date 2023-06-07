import 'package:flutter/material.dart';

import '../../shared/globals.dart';
class SideMenuTile extends StatelessWidget {

  const SideMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);


  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: 56,
          width: isActive? 288: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.all(Radius.circular(10)),

            ),
          ),
        ),
        ListTile(
          onTap: press,
          leading: SizedBox(
            height: 34,
            width: 34,
            child: Icon(icon,color: AppColors.lightWhite,),
          ),
          title: Text(
            title,
            style: TextStyle(color: AppColors.lightWhite),
          ),
        ),
      ],
    );
  }
}
