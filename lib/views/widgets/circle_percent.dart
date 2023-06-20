import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class CirclePercentWidget extends StatefulWidget {
  const CirclePercentWidget({super.key, required this.percent});
  final double percent;

  @override
  State<CirclePercentWidget> createState() => _CirclePercentWidgetState();
}

class _CirclePercentWidgetState extends State<CirclePercentWidget> {

  Color getProgressColor(){
    if (widget.percent <= 0.3) {
      return Colors.red;
    }
    if (widget.percent <= 0.6) {
      return Colors.yellow;
    }
    if (widget.percent <= 0.9) {
      return Colors.purple;
    }
    return Colors.green;
  }

  String getPercentText() {
    int percent =  (widget.percent * 100).toInt();
    String s = "$percent%";
    return s;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black54,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 12.0,
            animation: true,
            percent: widget.percent,
            center: Text(
              getPercentText(),
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: getProgressColor(),
          ),
        ),
      ),
    );
  }
}
