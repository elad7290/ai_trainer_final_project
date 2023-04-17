import '../db_access/user_db.dart';
import '../shared/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<LoginError> login(String email, String password) async {
  return await loginUser(email: email.trim(), password: password.trim());
}

Future<String?> register(String email, String password) async {
  return await registerUser(email: email.trim(), password: password.trim());
}

User get() {
  return getUser();
}

void logout() {
  logoutUser();
}