import '../models/progress_point.dart';

//TODO: fix this!!
// static data need be dynamic in the further
List<ProgressPoint> getProgressPoint(){
  final List<ProgressPoint> data = [];
  data.add(ProgressPoint(month: 1, percent: 20));
  data.add(ProgressPoint(month: 2, percent: 37));
  data.add(ProgressPoint(month: 3, percent: 58));
  data.add(ProgressPoint(month: 4, percent: 85));
  data.add(ProgressPoint(month: 5, percent: 98));
  return data;
}