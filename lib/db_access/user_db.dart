import 'package:firebase_auth/firebase_auth.dart';
import '../shared/globals.dart';


Future<LoginError> loginUser({required String email, required String password}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if (user != null) {
        return LoginError.success;
      }
  } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        return LoginError.userNotExist;
      }
    }
    return LoginError.errorDbConnection;
}

Future<String?> registerUser({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password);
  } on FirebaseAuthException catch(e) {
    return e.message;
  }
  return null;
}

User getUser() {
  return FirebaseAuth.instance.currentUser!;
}

void logoutUser() {
  FirebaseAuth.instance.signOut();
}




