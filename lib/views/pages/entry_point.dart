import 'dart:math';
import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/views/pages/home_page.dart';
import 'package:ai_trainer/views/pages/side_menu.dart';
import 'package:ai_trainer/views/widgets/menu_button_widget.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  bool isSideBarClosed = true;
  bool isSideMenuClosed = true;
  MyUser? user;
  bool isUserInitialized = false;

  late Widget current_page;

  void onPress() => setState(() {
    isSideBarClosed = !isSideBarClosed;
    if(isSideMenuClosed){
      _animationController.forward();
    }
    else{
      _animationController.reverse();
    }
    isSideMenuClosed = isSideBarClosed;
  });

  void changePage(m) => setState(() {
    current_page = m["screen"](user!);
  });

  @override
  void initState() {
    initUser();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200))..addListener(() {
          setState(() { });
    });
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController,
            curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
        CurvedAnimation(parent: _animationController,
            curve: Curves.fastOutSlowIn));


    super.initState();
  }

  void initUser() async {
    user = await getUserInfo();
    setState(() {
      if(user!= null){
        isUserInitialized = true;
        current_page = HomePage(user: user,);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isUserInitialized){
      return Scaffold(
        backgroundColor: Global.lightBlack,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: 288,
                left: isSideMenuClosed? -288: 0 ,
                height: MediaQuery.of(context).size.height,
                child: SideMenu(changePage: changePage, user: user!)
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
              //we rotate 30 degree
                ..rotateY(animation.value - 30 *animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265,0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child: current_page,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 16,
              child: MenuBtn(
                press: onPress,
                isMenuClosed: isSideBarClosed,
              ),
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }


  }
}
