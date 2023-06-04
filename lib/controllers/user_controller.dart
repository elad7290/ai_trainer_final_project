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
  try {
    User? authUser = await UserDB.register(email: email.trim(), password: password.trim());
    if (authUser != null) {
      MyUser myUser = MyUser(name: name,
          email: email.trim(),
          birthDate: DateTime.parse(birthDate),
          level: 0,
          weight: double.parse(weight),
          height: double.parse(height),
          progress_points: []);
      try {
        await UserDB.createDoc(myUser, authUser);
      } catch (e) {
        UserDB.deleteAuthUser(authUser);
        return e.toString();
      }
    }
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
  return null;
}

User getUserAuth() {
  return UserDB.getCurrentAuthUser();
}

Future<MyUser?> getUserInfo() async {
  try {
    return await UserDB.getInfo();
  } catch (e) {
    print(e.toString());
    return null;
  }
}

void logout() {
  UserDB.logout();
}

Future<MyUser?> getUserByRef(dynamic userRef) async{
  try {
    MyUser? user = await UserDB.getUserByRef(userRef);
    if (user != null) {
      return user;
    }
  } catch (e) {
    print("error in getUserByRef");
  }
  return null;
}

Future changeUserLevel(MyUser user, int level) async{
  try {
    await UserDB.changeLevel(level);
    user.level = level;
    await delete();
    await initial(user);
  } catch (e){
    print(e.toString());
  }
}