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

  static Future<String?> register({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  static Future<String?> createDoc(MyUser user, User authUser) async {
    var uid = authUser.uid;
    var userRef = db.collection('users').doc(uid);
    var snapshot = await userRef.get();
    if (!snapshot.exists) {
      try {
        var jsonUser = user.toJson();
        userRef.set(jsonUser);
      } catch (e) {
        return e.toString();
      }
      return null;
    } else {
      return "user didnt added";
    }
  }

  static Future<MyUser?> getInfo() async {
    String uid = auth.currentUser!.uid;
    var userRef = db.collection('users').doc(uid);
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      try {
        final data = snapshot.data() as Map<String, dynamic>;
        MyUser user = MyUser.fromJson(data);
        return user;
      } catch (e) {
        return null;
      }
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

  static Future<MyUser?> getUserFromRef(DocumentReference<Map<String, dynamic>> userRef) async {
    var snapshot = await userRef.get();
    if (snapshot.exists) {
      try {
        final data = snapshot.data() as Map<String, dynamic>;
        MyUser user = MyUser.fromJson(data);
        return user;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future changeLevel(int level) async{
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      userRef.update({
        'level': level
      });
    } catch (e) {
      print(e.toString());
    }

  }

}


