import 'package:ai_trainer/models/user_model.dart';
import 'package:ai_trainer/views/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final MyUser? user;

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
                style: TextStyle(fontSize: 14, color: Global.orange),
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
                  color: Global.white54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: LineChartWidget(points: user!.progress_points),
              ),
            ],
          ),
        ));
  }
}
