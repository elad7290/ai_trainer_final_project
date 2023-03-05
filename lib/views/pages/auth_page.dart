import 'package:ai_trainer/views/pages/login_page.dart';
import 'package:ai_trainer/views/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;

  void toggle() => setState(() {
    isLogin = !isLogin;
  });

  @override
  Widget build(BuildContext context) {
    if (isLogin){
      return LoginPage(onClickedSignUp: toggle,);
    } else {
      return RegisterPage(onClickedLogin: toggle);
    }
  }

}
