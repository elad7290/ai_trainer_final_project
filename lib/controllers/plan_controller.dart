import 'package:ai_trainer/models/user_model.dart';

import '../db_access/plan_db.dart';
import '../models/plan_model.dart';

Future<Plan?> getPlan(MyUser user) async {
  if (user.level > 0) {
    return await PlanDB.getPlanInfo(user);
  }
  else {
    //TODO: navigate to questionnaire
    return null;
  }
}

Future<List<String>> getExercisesID(MyUser user) async {
  return await PlanDB.getPlanExercisesID(user);
}