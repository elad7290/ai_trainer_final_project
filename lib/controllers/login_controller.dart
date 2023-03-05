import '../db_access/user_db.dart';
import '../shared/globals.dart';

Future<LoginError> login(String email, String password) async {
  return await loginUser(email: email.trim(), password: password.trim());
}