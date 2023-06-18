import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import '../../controllers/exercise_controller.dart';
import '../../shared/globals.dart';
import '../widgets/circle_percent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final MyUser? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double percent = 0;

  @override
  void initState() {
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
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "data",
                style: TextStyle(fontSize: 14, color: AppColors.orange),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.white54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: LineChartWidget(points: widget.user!.progress_points),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3.5,
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.white54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CirclePercentWidget(percent: percent,),
              ),
            ],
          ),
        ));
  }
}
