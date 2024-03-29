import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/views/widgets/info_card.dart';
import 'package:ai_trainer/views/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';

import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import 'auth_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.changePage, required this.user}) : super(key: key);

  final MyUser user;
  final void Function(dynamic) changePage;

  @override
  State<SideMenu> createState() => _SideMenuState();
}



class _SideMenuState extends State<SideMenu> {

  Map<String,dynamic> selectedMenu= menu.first;

  Future _logout() async{
    logout();
    final navigator = Navigator.of(context);
    navigator.pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppColors.lightBlack,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InfoCard(
                    name: widget.user.name,
                    email: widget.user.email,
                    image: widget.user.profile_image,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Divider(
                    color: AppColors.lightWhite,
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
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Divider(
                    color: AppColors.lightWhite,
                    height: 1,
                  ),
                ),
                SideMenuTile(
                  icon: Icons.arrow_back,
                  title: 'Sign Out',
                  press: _logout,
                  isActive: false,
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
