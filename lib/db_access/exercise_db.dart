import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/weekly_training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/user_controller.dart';


class ExerciseDB {
  static var db = FirebaseFirestore.instance;

  static Future<Exercise?> getExerciseFromRef(
      DocumentReference<Map<String, dynamic>> exRef) async {
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

  static Future<Exercise?> getExerciseById(String id) async{
    var exRef = FirebaseFirestore.instance.collection('exercises').doc(id);
    var snapshot = await exRef.get();
    if (snapshot.exists) {
      try {
        final data = snapshot.data() as Map<String, dynamic>;
        Exercise ex = Exercise.fromJson(data);
        return ex;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      return null;
    }

  }

  static Future<List<Exercise>> getExercisesFromUser() async {
    List<Exercise> exercises = [];
    try {
      User user = getUserAuth();
      String user_id = user.uid;
      var weeklyTrainingRef = db.collection('weekly_training');
      var query = weeklyTrainingRef.where("user_id", isEqualTo: user_id);
      var snapshot = await query.get();
      for (var docSnapshot in snapshot.docs) {
        var data = docSnapshot.data();
        String ex_id = data['exercise_id'];
        var ex = await getExerciseById(ex_id);
        if (ex != null) {
          exercises.add(ex);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return exercises;
  }

  static Future initialExercises(List<String> exercisesId) async {
    // create weekly_training docs
    try {
      final user = getUserAuth();
      var user_id = user.uid;
      for (var exercise_id in exercisesId){
        var wt = WeeklyTraining(user_id: user_id, exercise_id: exercise_id, is_done: false);
        var data = wt.toJson();
        await db.collection('weekly_training').add(data);
      }
    } catch (e){
      print(e.toString());
    }
  }

  static Future deleteExercises() async {
    try {
      User user = getUserAuth();
      String user_id = user.uid;
      var weeklyTrainingRef = db.collection('weekly_training');
      var query = weeklyTrainingRef.where("user_id", isEqualTo: user_id);
      var snapshot = await query.get();
      for (var docSnapshot in snapshot.docs) {
        await docSnapshot.reference.delete();
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
