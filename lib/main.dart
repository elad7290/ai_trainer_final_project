import 'package:ai_trainer/shared/globals.dart';
import 'package:ai_trainer/shared/utils.dart';
import 'package:ai_trainer/views/pages/auth_page.dart';
import 'package:ai_trainer/views/pages/entry_point.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        home: const EntryPoint(),
        theme: ThemeData(
            primarySwatch: AppColors.orange,
            brightness: Brightness.dark
        ),
      );
    } else {
      // login or register
      return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        theme: ThemeData(
          primarySwatch: AppColors.orange,
          brightness: Brightness.dark
        ),
      );
    }
  }

}
