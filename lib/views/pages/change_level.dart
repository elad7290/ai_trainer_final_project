import 'package:ai_trainer/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../shared/globals.dart';
import 'fitness_questionnaire.dart';

class ChangeLevelPage extends StatefulWidget {
  const ChangeLevelPage({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<ChangeLevelPage> createState() => _ChangeLevelPageState();
}

class _ChangeLevelPageState extends State<ChangeLevelPage> {
  bool isLevelChanged = false;

  void levelUpdated() {
    setState(() {
      isLevelChanged = true;
    });

  }


  void navigateToQuestionnaire() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FitnessQuestionnaire(user: widget.user, levelUpdated: levelUpdated,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Level',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.orange),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: isLevelChanged ?
         const Column(
          children: [
            Text(
              "Your level has been changed successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              "you can start workout now!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        )
            :
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Text(
              "To change your level please fill out a questionnaire",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              width: 250,
              child: ElevatedButton(
                onPressed: navigateToQuestionnaire,
                child: const Row(
                    children: [
                      Text('Fill The Questionnaire', style: TextStyle(fontSize: 16,)),
                      Icon(Icons.arrow_right),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
