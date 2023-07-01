import 'package:firebase_auth/firebase_auth.dart';

class AuthUserDB {

  static var auth = FirebaseAuth.instance;

  static Future<User?> login({required String email, required String password}) async {
    User? user;
    UserCredential userCredential =
    await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    return user;
  }

  static Future<User?> register({required String email, required String password}) async {
    UserCredential userCredential =  await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  static Future delete(User authUser) async{
    await authUser.delete();
  }

  static User getCurrentUser() {
    return auth.currentUser!;
  }

  // static Future<User?> getAuthUser(String email, String password) async {
  //   UserCredential userCredential = await auth
  //       .signInWithEmailAndPassword(email: email, password: password);
  //   User? user = userCredential.user;
  //   return user;
  // }

  static void logout() {
    auth.signOut();
  }

  static Future editUser(String? email, String? password) async{
    var user = getCurrentUser();
    if(email != null && email != '') await user.updateEmail(email);
    if(password != null && password != '') await user.updatePassword(password);
  }


}


