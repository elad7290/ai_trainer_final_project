import 'package:ai_trainer/controllers/exercise_controller.dart';
import 'package:ai_trainer/models/user_model.dart';
import '../db_access/user_db.dart';
import '../shared/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';

//TODO: errors by myself
Future<LoginError> login(String email, String password) async {
  String? error = await loginUser(email: email.trim(), password: password.trim());
  if (error == null) {
    return LoginError.success;
  } else if (error == "user-not-found") {
    return LoginError.userNotExist;
  }
  else{
    return LoginError.errorDbConnection;
  }
}

Future<String?> register(String email, String password, String name, String birthDate, String weight, String height) async {
  String? s = await registerUser(email: email.trim(), password: password.trim());
  if (s != null) {
    return s;
  }
  User? autUser = await getAuthUser(email.trim(), password.trim());
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
  return await createUserDoc(myUser, autUser);
}

User get() {
  return getCurrentAuthUser();
}

Future<MyUser?> getUser() async {
  return await getUserInfo();
}

void logout() {
  logoutUser();
}

Future<MyUser?> getUserByRef(dynamic userRef) async{
  var u = await getUserFromRef(userRef);
  if (u==null){
    print("error in getUserByRef");
  }
  return u;
}

Future changeUserLevel(MyUser user, int level) async{
  await changeLevel(level);
  user.level = level;
  await delete();
  await initial(user);
}