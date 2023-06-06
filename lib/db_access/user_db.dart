import 'package:ai_trainer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDB {
  static var db = FirebaseFirestore.instance;
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

  static Future createDoc(MyUser user, User authUser) async {
    var uid = authUser.uid;
    var userRef = db.collection('users').doc(uid);
    var snapshot = await userRef.get();
    if (!snapshot.exists) {
      var jsonUser = user.toJson();
      userRef.set(jsonUser);
    } else {
      print("user didnt added");
    }
  }

  static Future deleteAuthUser(User authUser) async{
    await authUser.delete();
  }

  static Future<MyUser?> getInfo() async {
    String uid = getCurrentAuthUser().uid;
    var userRef = db.collection('users').doc(uid);
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      MyUser user = MyUser.fromJson(data);
      return user;
    } else {
      return null;
    }
  }

  static User getCurrentAuthUser() {
    return auth.currentUser!;
  }

  static Future<User?> getAuthUser(String email, String password) async {
    UserCredential userCredential = await auth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user;
  }

  static void logout() {
    auth.signOut();
  }

  static Future<MyUser?> getUserByRef(DocumentReference<Map<String, dynamic>> userRef) async {
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      MyUser user = MyUser.fromJson(data);
      return user;
    } else {
      return null;
    }
  }

  static Future changeLevel(int level) async{
    String uid = getCurrentAuthUser().uid;
    var userRef = db.collection('users').doc(uid);
    await userRef.update({
      'level': level
    });
  }

  static Future editMyUser (Map<String, dynamic> data) async {
    var uid = getCurrentAuthUser().uid;
    await db.collection('users').doc(uid).update(data);
  }

  static Future editAuthUser(String? email, String? password) async{
    var user = getCurrentAuthUser();
    if(email != null && email != '') await user.updateEmail(email);
    if(password != null && password != '') await user.updatePassword(password);
  }


}


