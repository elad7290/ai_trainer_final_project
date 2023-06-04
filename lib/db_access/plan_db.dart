import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plan_model.dart';
import '../models/user_model.dart';

class PlanDB {
  static var db = FirebaseFirestore.instance;

  static Future<Plan?> getPlanInfo(MyUser user) async {
    var planRef = db.collection('plans');
    var query = planRef.where("level", isEqualTo: user.level).limit(1);
    var snapshot = await query.get();
    final data = snapshot.docs[0].data() as Map<String, dynamic>;
    Plan plan = await Plan.fromJson(data);
    return plan;
  }

  static Future<List<String>> getPlanExercisesID(MyUser user) async {
    List<String> exercisesId = [];
    var planRef = db.collection('plans');
    var query = planRef.where("level", isEqualTo: user.level).limit(1);
    var snapshot = await query.get();
    final data = snapshot.docs[0].data() as Map<String, dynamic>;
    var exercises = data['exercises'];
    for (var ex in exercises){
      exercisesId.add(ex);
    }
    return exercisesId;
  }

}
