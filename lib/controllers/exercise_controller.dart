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