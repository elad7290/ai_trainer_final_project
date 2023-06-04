import 'package:ai_trainer/models/user_model.dart';

import '../db_access/plan_db.dart';
import '../models/plan_model.dart';

Future<Plan?> getPlan(MyUser user) async {
  try {
    if (user.level > 0) {
      return await PlanDB.getPlanInfo(user);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<String>> getExercisesID(MyUser user) async {
  try {
    return await PlanDB.getPlanExercisesID(user);
  } catch (e) {
    print(e.toString());
    return [];
  }
}