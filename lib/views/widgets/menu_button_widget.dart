import 'package:flutter/material.dart';

import '../../shared/globals.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({Key? key, required this.press, required this.isMenuClosed}) : super(key: key);

  final VoidCallback press;
  final bool isMenuClosed;
  //final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                color: AppColors.lightBlack,
                offset: Offset(0,3),
                blurRadius: 8,
              )]
          ),
          child: isMenuClosed?  const Icon(Icons.menu): const Icon(Icons.close) ,
        ),
      ),
    );
  }
}
