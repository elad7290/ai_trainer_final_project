import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/pages/auth_page.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final MyUser? user;

  @override
  Widget build(BuildContext context) {
    final user = get();
    Future _logout() async{
      logout();
      final navigator = Navigator.of(context);
      navigator.pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
    }
    //TODO: need to be review again!!!

    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signed in as',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                user.email!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                  ),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                onPressed: _logout,
              )
            ],
          ),
        ));


  }
}
