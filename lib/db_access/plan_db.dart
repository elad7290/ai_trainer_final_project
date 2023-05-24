import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plan_model.dart';
import '../models/user_model.dart';

class PlanDB {
  static var db = FirebaseFirestore.instance;

  static Future<Plan?> getPlanInfo(MyUser user) async {
    try {
      var planRef = db.collection('plans');
      var query = planRef.where("level", isEqualTo: user.level).limit(1);
      var snapshot = await query.get();
      final data = snapshot.docs[0] as Map<String, dynamic>;
      Plan plan = Plan.fromJson(data);
      return plan;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
