import 'package:ai_trainer/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../controllers/plan_controller.dart';
import '../../models/plan_model.dart';
import '../../shared/globals.dart';

class Info extends StatefulWidget {
  const Info({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Plan? plan;
  bool isPlanInitialized = false;

  @override
  void initState() {
    initPlan();
    super.initState();
  }

  void initPlan() async {
    plan = await getPlan(widget.user);
    setState(() {
      if (plan != null) {
        isPlanInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Information',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.orange),
        ),
        centerTitle: true,
      ),
      body: isPlanInitialized ?
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(
              plan!.information,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      )
          :
      const SizedBox(),
    );
  }
}
