import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/views/widgets/info_card.dart';
import 'package:ai_trainer/views/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

List<Map<String,dynamic>> menu = [
  {
    "icon": Icons.home,
    "title": "Home",
  },
  {
    "icon": Icons.person,
    "title": "My Profile",
  },
  {
    "icon": Icons.home,
    "title": "Home",
  },
];

class _SideMenuState extends State<SideMenu> {

  Map<String,dynamic> selectedMenu= menu.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Global.lightBlack,
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(name: "elad", email: "email"),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Divider(
                  color: Global.lightWhite,
                  height: 1,
                ),
              ),
              ...menu.map((m) =>
              SideMenuTile(
                icon: m['icon'],
                title: m['title'],
                press: (){
                  setState(() {
                    selectedMenu=m;
                  });
                },
                isActive: selectedMenu==m,
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
