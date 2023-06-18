import 'package:ai_trainer/controllers/plan_controller.dart';
import 'package:ai_trainer/models/user_model.dart';
import '../db_access/exercise_db.dart';
import '../models/exercise_model.dart';

Future<List<Exercise>> getExercisesByRef(dynamic exercisesRef) async {
  List<Exercise> exercises = [];
  for (var exRef in exercisesRef) {
    var ex = await getExerciseByRef(exRef);
    if (ex != null) {
      exercises.add(ex);
    }
  }
  return exercises;
}

Future<Exercise?> getExerciseByRef(dynamic exRef) async {
  try {
    return await ExerciseDB.getExerciseByRef(exRef);
  } catch (e) {
    return null;
  }
}

Future<List<Exercise>> getExercises() async {
  try {
    return await ExerciseDB.getExercisesFromUser();
  } catch (e) {
    print(e.toString());
    return [];
  }
}

Future<double> getProgress() async {
  try {
    double percent = await ExerciseDB.getProgress();
    if (percent != double.nan) {
      return percent;
    } else {
      return 0;
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}

Future initialExercises(MyUser user) async {
  try {
    var exercisesId = await getExercisesID(user);
    await ExerciseDB.initial(exercisesId);
  } catch (e) {
    print(e.toString());
  }
}

Future deleteExercises() async {
  try {
    await ExerciseDB.delete();
  } catch (e) {
    print(e.toString());
  }
}
