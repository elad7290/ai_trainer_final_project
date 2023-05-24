import 'package:ai_trainer/models/exercise_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseDB {
  static var db = FirebaseFirestore.instance;

  static Future<Exercise?> getExerciseFromRef(DocumentReference<Map<String, dynamic>> exRef) async {
      var snapshot = await exRef.get();
      if (snapshot.exists) {
        try {
          final data = snapshot.data() as Map<String, dynamic>;
          Exercise ex = Exercise.fromJson(data);
          return ex;
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
  }
}