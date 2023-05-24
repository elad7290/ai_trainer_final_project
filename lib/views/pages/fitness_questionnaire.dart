import 'package:flutter/material.dart';

import '../../shared/globals.dart';

class FitnessQuestionnaire extends StatefulWidget {
  const FitnessQuestionnaire({Key? key}) : super(key: key);


  @override
  FitnessQuestionnaireState createState() => FitnessQuestionnaireState();
}

class FitnessQuestionnaireState extends State<FitnessQuestionnaire> {
  // Define the questions and possible answers
  final List<String> _questions = [
    "How many days per week do you currently exercise?",
    "What is your primary goal for fitness training?",
    "How much time can you commit to exercise each day?",
    "What type of exercise do you prefer?",
    "How much experience do you have with exercise?",
    "How would you describe your current fitness level?",
    "Do you have any injuries or health conditions that may limit your exercise?",
    "How would you rate your diet?",
    "How important is variety in your exercise routine?",
    "How motivated are you to achieve your fitness goals?"
  ];

  final List<List<String>> _answers = [
    ["1 day", "2-3 days", "4-5 days", "6-7 days"],
    ["Weight loss", "Muscle gain", "General health"],
    ["Less than 30 minutes", "30-60 minutes", "More than 60 minutes"],
    ["Cardio", "Strength training", "Both"],
    ["Beginner", "Intermediate", "Advanced"],
    ["Poor", "Fair", "Good", "Excellent"],
    ["Yes", "No"],
    ["Poor", "Fair", "Good", "Excellent"],
    ["Very important", "Somewhat important", "Not important"],
    ["Very motivated", "Somewhat motivated", "Not very motivated"]
  ];

  final List<List<int>> _scoringSystem = [
    [1, 2, 3, 4],
    [2, 4, 6],
    [1, 2, 3],
    [1, 2, 3],
    [2, 4, 6],
    [1, 2, 3, 4],
    [2, 0],
    [1, 2, 3, 4],
    [2, 3, 5],
    [2, 4, 6]
  ];

  final List<int> _weights = [
    3,
    4,
    2,
    2,
    3,
    3,
    2,
    3,
    2,
    2
  ];

  // Initialize the state variables
  String _answer = "";
  int _score = 0;
  int _questionIndex = 0;
  String _fitnessLevel = "";

  // Define a function to calculate the score based on the selected answer
  void _calculateScore(String answer) {
    setState(() {
      _answer = answer;
      _score += _scoringSystem[_questionIndex][_answers[_questionIndex].indexOf(answer)] * _weights[_questionIndex];
      _answer = "";
    });

    if (_questionIndex == _questions.length - 1) {
      _determineFitnessLevel();
    } else {
      setState(() {
        _questionIndex++;
      });
    }
  }

  // Define a function to determine the fitness level based on the score
  void _determineFitnessLevel() {
    if (_score >= 50) {
      _fitnessLevel = "Advanced";
    } else if (_score >= 30) {
      _fitnessLevel = "Intermediate";
    } else {
      _fitnessLevel = "Beginner";
    }
    //TODO: save users level
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Questionnaire"),
        centerTitle: true,
        backgroundColor: Global.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${_questionIndex + 1} of ${_questions.length}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              _questions[_questionIndex],
              style: const TextStyle(fontSize: 24.0, color: Global.orange),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _answers[_questionIndex]
                    .map(
                      (answer) => GestureDetector(
                    onTap: () => _calculateScore(answer),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: _answer == answer ? Colors.blue : Colors.grey[200],
                        border: Border.all(
                          color: _answer == answer ? Colors.blue : Colors.grey[400]!,
                          width: 2.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        answer,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: _answer == answer ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_fitnessLevel.isNotEmpty)
              Column(
                children: [
                  Text(
                    "Based on your answers, your fitness level is $_fitnessLevel!",
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 16.0,),
                  ElevatedButton(
                    onPressed: () {
                      //TODO: Handle "Done" button pressed -> nevigate
                    },
                    child: Text('Done', style: TextStyle(fontSize: 22),),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(250.0, 50.0),),
                    ),
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}