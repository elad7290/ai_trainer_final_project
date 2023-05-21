import 'package:ai_trainer/models/user_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> loginUser({required String email, required String password}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    if (user != null) {
      return null;
    }
  } on FirebaseAuthException catch (e) {
    return e.code;
  }
  return "error on db connection";
}

Future<String?> registerUser(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
  return null;
}

Future<String?> createUserDoc(MyUser user, User authUser) async {
  var uid = authUser.uid;
  var firestore = FirebaseFirestore.instance;
  var userRef = firestore.collection('users').doc(uid);
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

Future<MyUser?> getUserInfo() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var userRef = FirebaseFirestore.instance.collection('users').doc(uid);
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

User getCurrentAuthUser() {
  return FirebaseAuth.instance.currentUser!;
}

Future<User?> getAuthUser(String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  User? user = userCredential.user;
  return user;
}

void logoutUser() {
  FirebaseAuth.instance.signOut();
}
