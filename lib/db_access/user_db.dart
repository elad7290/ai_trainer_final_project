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


