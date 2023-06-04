import 'package:ai_trainer/controllers/exercise_controller.dart';
import 'package:ai_trainer/models/user_model.dart';
import '../db_access/user_db.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/utils.dart';

Future<User?> login(String email, String password) async {
  try {
    User? user = await UserDB.login(email: email.trim(), password: password.trim());
    if (user != null) {
      return user;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      Utils.showSnackBar("Incorrect email or password.");
      return null;
    }
  }
  Utils.showSnackBar("Something went wrong. Please try again later.");
  return null;
}

Future<String?> register(String email, String password, String name, String birthDate, String weight, String height) async {
  String? s = await UserDB.register(email: email.trim(), password: password.trim());
  if (s != null) {
    return s;
  }
  User? autUser = await UserDB.getAuthUser(email.trim(), password.trim());
  if (autUser == null) {
    return "error";
  }
  MyUser myUser = MyUser(name: name,
      email: email.trim(),
      birthDate: DateTime.parse(birthDate),
      level: 0,
      weight: double.parse(weight),
      height: double.parse(height),
      progress_points: []);
  return await UserDB.createDoc(myUser, autUser);
}

User get() {
  return UserDB.getCurrentAuthUser();
}

Future<MyUser?> getUser() async {
  return await UserDB.getInfo();
}

void logout() {
  UserDB.logout();
}

Future<MyUser?> getUserByRef(dynamic userRef) async{
  var u = await UserDB.getUserFromRef(userRef);
  if (u==null){
    print("error in getUserByRef");
  }
  return u;
}

Future changeUserLevel(MyUser user, int level) async{
  await UserDB.changeLevel(level);
  user.level = level;
  await delete();
  await initial(user);
}