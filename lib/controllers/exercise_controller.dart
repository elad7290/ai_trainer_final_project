import 'package:ai_trainer/controllers/plan_controller.dart';
import 'package:ai_trainer/models/user_model.dart';

import '../db_access/exercise_db.dart';
import '../models/exercise_model.dart';

Future<List<Exercise>> getExercisesByRef(dynamic exercises) async{
  List<Exercise> exs = <Exercise>[];
  for (var exRef in exercises){
    var e = await ExerciseDB.getExerciseFromRef(exRef);
    if (e!=null){
      exs.add(e);
    }
  }
  return exs;
}

Future<Exercise?> getExerciseByRef(dynamic exRef) async{
  var e = await ExerciseDB.getExerciseFromRef(exRef);
  if (e==null){
    print("error in getExerciseByRef");
  }
  return e;
}

Future<List<Exercise>> getExercises() async {
  return await ExerciseDB.getExercisesFromUser();
}

Future initial(MyUser user) async {
  var exercisesId = await getExercisesID(user);
  await ExerciseDB.initialExercises(exercisesId);
}

Future delete() async {
  await ExerciseDB.deleteExercises();
}
