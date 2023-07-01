import 'package:ai_trainer/controllers/plan_controller.dart';
import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/shared/utils.dart';
import '../db_access/exercise_db.dart';
import '../models/exercise_model.dart';

// returns the weekly exercises that the user has not yet finished
Future<List<Exercise>> getExercises() async {
  try {
    return await ExerciseDB.getExercisesFromUser();
  } catch (e) {
    print(e.toString());
    return [];
  }
}

// returns the user's weekly progress percent
Future<double> getProgress() async {
  try {
    double percent = await ExerciseDB.getProgress();
    if (percent.isFinite) {
      return percent;
    } else {
      return 0;
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}

Future finishExercise(String exercise_id) async {
  try {
    await ExerciseDB.finished(exercise_id);
  } catch (e) {
    print(e);
    Utils.showSnackBar("something went wrong");
  }
}

// Enter new exercises for the user in the weekly training table according to his level
Future initialExercises(MyUser user) async {
  try {
    var exercisesId = await getExercisesID(user);
    await ExerciseDB.initial(exercisesId);
  } catch (e) {
    print(e.toString());
  }
}

// Delete exercises for the user in the weekly training table
Future deleteExercises() async {
  try {
    await ExerciseDB.delete();
  } catch (e) {
    print(e.toString());
  }
}
