import 'package:ai_trainer/controllers/user_controller.dart';
import 'package:ai_trainer/db_access/user_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#signInWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));
}
class MockUser extends Mock implements User {}
class MockUserCredential extends Mock implements UserCredential {}

void main() async {
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockCredential;
  late MockUser mockUser;

  setUp(() {

    mockAuth = MockFirebaseAuth();
    mockCredential = MockUserCredential();
    mockUser = MockUser();
    when(mockCredential.user).thenReturn(mockUser); // IMPORTANT
    UserDB.auth = mockAuth;
  });

  group('login', () {
    test('description', () async {
      when(mockAuth.signInWithEmailAndPassword(email: any, password: any))
          .thenAnswer((_) async => mockCredential);
      var user = await login('chen@gmail.com', '123456');
      expect(user, isNot(null));
    });
  });
}