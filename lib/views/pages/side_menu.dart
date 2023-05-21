import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/views/widgets/info_card.dart';
import 'package:ai_trainer/views/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';
import '../../models/user_table.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.changePage}) : super(key: key);

  final void Function(dynamic) changePage;

  @override
  State<SideMenu> createState() => _SideMenuState();
}



class _SideMenuState extends State<SideMenu> {

  Map<String,dynamic> selectedMenu= menu.first;
  MyUser? user;

  @override
  void initState() {
    initUser();
    super.initState();
  }

  void initUser() async {
    user = await getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null){
      return Scaffold(
        body: Container(
          width: 288,
          height: double.infinity,
          color: Global.lightBlack,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InfoCard(
                      name: user!.name,
                      email: user!.email,
                  ),
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
    } else {
      return const SizedBox();
    }
  }
}
