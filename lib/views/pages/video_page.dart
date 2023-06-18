import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/views/pages/camera_page.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  Exercise exercise;

  VideoPage({Key? key, required this.exercise}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late BetterPlayerController betterPlayerController;
  GlobalKey betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(aspectRatio: 16/9, fit: BoxFit.contain,autoPlay: true);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.exercise.videoURL);
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(dataSource);
    betterPlayerController.setBetterPlayerGlobalKey(betterPlayerKey);
    super.initState();
  }
  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //TODO: here send to CameraScreen the exercise
    void startWorkOut(){
      print(widget.exercise.name + "!!!!!!!!!!!!!!!!!!!");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen(exercise: widget.exercise.name)),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Get ready to work!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  heightFactor: 0.5, // Adjust the height factor as needed
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(
                      key: betterPlayerKey,
                      controller: betterPlayerController,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){ startWorkOut(); },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: RichText(
                  text: TextSpan(
                    text: 'Tools needed:\n',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: widget.exercise.tools,
                        style: const TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
