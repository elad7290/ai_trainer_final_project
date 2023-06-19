import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/models/weekly_training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/user_controller.dart';


class ExerciseDB {
  static var db = FirebaseFirestore.instance;

  // static Future<Exercise?> getExerciseByRef(DocumentReference<Map<String, dynamic>> exRef) async {
  //   var snapshot = await exRef.get();
  //   if (snapshot.exists) {
  //     final data = snapshot.data() as Map<String, dynamic>;
  //     Exercise ex = Exercise.fromJson(data);
  //     return ex;
  //   } else {
  //     return null;
  //   }
  // }

  static Future<Exercise?> getExerciseById(String id) async{
    var exRef = FirebaseFirestore.instance.collection('exercises').doc(id);
    var snapshot = await exRef.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      Exercise ex = Exercise.fromJson(data);
      return ex;
    } else {
      return null;
    }

  }

  static Future<List<Exercise>> getExercisesFromUser() async {
    List<Exercise> exercises = [];
    User user = getUserAuth();
    String user_id = user.uid;
    var weeklyTrainingRef = db.collection('weekly_training');
    var query = weeklyTrainingRef.where("user_id", isEqualTo: user_id).where("is_done", isEqualTo: false);
    var snapshot = await query.get();
    for (var docSnapshot in snapshot.docs) {
      var data = docSnapshot.data();
      String ex_id = data['exercise_id'];
      var ex = await getExerciseById(ex_id);
      if (ex != null) {
        exercises.add(ex);
      }
    }
    return exercises;
  }

  static Future<double> getProgress() async {
    User user = getUserAuth();
    String user_id = user.uid;
    var weeklyTrainingRef = db.collection('weekly_training');
    var ex_count_query = weeklyTrainingRef.where("user_id", isEqualTo: user_id).count();
    var ex_done_count_query = weeklyTrainingRef.where("user_id", isEqualTo: user_id).where("is_done",  isEqualTo: true).count();
    var snapshot_ex_count = await ex_count_query.get();
    var snapshot_ex_done_count = await ex_done_count_query.get();
    return snapshot_ex_done_count.count / snapshot_ex_count.count;
  }

  static Future initial(List<String> exercisesId) async {
    // create weekly_training docs
    final user = getUserAuth();
    var user_id = user.uid;
    for (var exercise_id in exercisesId){
      var wt = WeeklyTraining(user_id: user_id, exercise_id: exercise_id, is_done: false);
      var data = wt.toJson();
      await db.collection('weekly_training').add(data);
    }
  }

  static Future delete() async {
    User user = getUserAuth();
    String user_id = user.uid;
    var weeklyTrainingRef = db.collection('weekly_training');
    var query = weeklyTrainingRef.where("user_id", isEqualTo: user_id);
    var snapshot = await query.get();
    for (var docSnapshot in snapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }


}
