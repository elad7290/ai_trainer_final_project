import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class MyUserDB {

  static var db = FirebaseFirestore.instance;

  static Future create(MyUser user, User authUser) async {
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

  static Future<MyUser?> getInfo() async {
    String uid = getUserAuth().uid;
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

  static Future changeLevel(int level) async{
    String uid = getUserAuth().uid;
    var userRef = db.collection('users').doc(uid);
    await userRef.update({
      'level': level
    });
  }

  static Future editUser (Map<String, dynamic> data) async {
    var uid = getUserAuth().uid;
    await db.collection('users').doc(uid).update(data);
  }

}