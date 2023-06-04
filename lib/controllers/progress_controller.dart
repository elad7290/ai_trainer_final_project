import '../models/progress_point.dart';

//TODO: fix this!!
// static data need be dynamic in the further
List<ProgressPoint> getProgressPoint() {
  final List<double> percents = [15, 13, 34, 56, 56, 87, 12, 33, 99, 90];
  final List<ProgressPoint> data = percents
      .asMap().entries.map((e) => ProgressPoint(week: e.key, percent: e.value)).toList();
  return data;
}
