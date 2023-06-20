import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import '../../controllers/exercise_controller.dart';
import '../../shared/globals.dart';
import '../widgets/circle_percent.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double percent = 0;
  late double bmi;

  @override
  void initState() {
    bmi = widget.user.weight / pow((widget.user.height) / 100, 2);
    initProgress();
    super.initState();
  }

  void initProgress() async {
    double p = await getProgress();
    setState(() {
      percent = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.orange),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Welcome, ${widget.user.name}!",
                  style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.white
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "Are you ready to see your progress?",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: 200,
                  height: 110,
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.white54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your BMI:",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.orangeAccent
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        bmi.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.white54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your Progress From the Beginning:",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.orangeAccent
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Expanded(child: LineChartWidget(points: widget.user.progress_points)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 2.7,
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.white54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your Weekly Progress:",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.orangeAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                          child: CirclePercentWidget(percent: percent,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
