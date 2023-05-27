import 'package:ai_trainer/views/pages/camera_page.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set the background color to orange
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedValue,
              hint: Text('Select a workout'),
              items: [
                DropdownMenuItem(
                  value: 'Workout A',
                  child: Text('Workout A'),
                ),
                DropdownMenuItem(
                  value: 'Workout B',
                  child: Text('Workout B'),
                ),
                DropdownMenuItem(
                  value: 'Workout C',
                  child: Text('Workout C'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedValue != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => CameraScreen(selectedValue: selectedValue!),
                    ),
                  );
                } else {
                  // Show a dialog or display an error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please select a workout.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Start Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
