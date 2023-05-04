import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/views/widgets/info_card.dart';
import 'package:ai_trainer/views/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.changePage}) : super(key: key);

  final void Function(dynamic) changePage;

  @override
  State<SideMenu> createState() => _SideMenuState();
}



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
          child: SingleChildScrollView(
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
                    widget.changePage(m);
                  },
                  isActive: selectedMenu==m,
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
