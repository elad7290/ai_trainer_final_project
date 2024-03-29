import 'dart:io';
import 'package:ai_trainer/controllers/exercise_controller.dart';
import 'package:ai_trainer/controllers/image_controller.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:intl/intl.dart';
import '../db_access/auth_user_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../db_access/my_user_db.dart';
import '../shared/utils.dart';

Future<User?> login(String email, String password) async {
  try {
    User? user =
        await AuthUserDB.login(email: email.trim(), password: password.trim());
    if (user != null) {
      return user;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found" || e.code == "wrong-password") {
      Utils.showSnackBar("Incorrect email or password.");
      return null;
    }
  }
  Utils.showSnackBar("Something went wrong. Please try again later.");
  return null;
}

Future<String?> register(String email, String password, String name,
    String birthDate, String weight, String height,File? image) async {
  try {
    User? authUser =
        await AuthUserDB.register(email: email.trim(), password: password.trim());
    if (authUser != null) {
      MyUser myUser = MyUser(
          name: name,
          email: email.trim(),
          birthDate: DateFormat('dd-MM-yyyy').parse(birthDate),
          level: 0,
          weight: double.parse(weight),
          height: double.parse(height),
          progress_points: [],
          profile_image: await ImageController.uploadImageToStorage(image));
      try {
        await MyUserDB.create(myUser, authUser);
      } catch (e) {
        AuthUserDB.delete(authUser);
        return e.toString();
      }
    }
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
  return null;
}

User getUserAuth() {
  return AuthUserDB.getCurrentUser();
}

Future<MyUser?> getUserInfo() async {
  try {
    return await MyUserDB.getInfo();
  } catch (e) {
    print(e.toString());
    return null;
  }
}

void logout() {
  AuthUserDB.logout();
}

Future changeUserLevel(MyUser user, int level) async {
  try {
    await MyUserDB.changeLevel(level);
    user.level = level;
    await deleteExercises();
    await initialExercises(user);
  } catch (e) {
    print(e.toString());
  }
}

Future editUser(String? email, String? password, String? name,
    String? birthDate, String? weight, String? height,File? image, MyUser user) async {
  Map<String, dynamic> json = {};
  if(email!=null && email!='') json['email'] = email.trim();
  if(name!=null && name!='') json['name'] = name.trim();
  if(birthDate!=null && birthDate!='') json['birthDate'] = DateTime.parse(birthDate);
  if(weight!=null && weight!='') json['weight'] = double.parse(weight);
  if(height!=null && height!='') json['height'] = double.parse(height);
  if(image!=null) json['profile_image'] = await ImageController.uploadImageToStorage(image);
  try{
    await AuthUserDB.editUser(email, password);
    await MyUserDB.editUser(json);
    updateUser(user, json);
    Utils.showSuccessSnackBar("Your personal details have been successfully updated.");
  } on FirebaseAuthException catch (e) {
    if (e.code == "email-already-in-use") {
      Utils.showSnackBar("This email is already in use.");
    }
    if (e.code == "requires-recent-login"){
      Utils.showSnackBar('In order to do this, you are required to login again to the app.');
    }
  } catch (e){
    Utils.showSnackBar('Something went wrong. Please try again later.');
    print(e.toString());
  }
}

void updateUser(MyUser user, Map<String, dynamic> json) {
  if(json.containsKey('email')) user.email = json['email'];
  if(json.containsKey('name')) user.name = json['name'];
  if(json.containsKey('birthDate')) user.birthDate = json['birthDate'];
  if(json.containsKey('weight')) user.weight = json['weight'];
  if(json.containsKey('height')) user.height = json['height'];
  if(json.containsKey('profile_image')) user.profile_image = json['profile_image'];
}

