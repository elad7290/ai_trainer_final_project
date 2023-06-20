import 'package:ai_trainer/models/exercise_model.dart';
import 'package:ai_trainer/views/pages/camera_page.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class VideoPage extends StatefulWidget {
  final Exercise exercise;
  final MyUser user;
  final void Function() finished;

  const VideoPage({Key? key, required this.exercise, required this.user, required this.finished}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late BetterPlayerController betterPlayerController;
  GlobalKey betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(aspectRatio: 16/9, fit: BoxFit.contain,autoPlay: true);
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

  void startWorkOut(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen(exercise: widget.exercise, user: widget.user, finished: widget.finished,)),
    );
  }

  @override
  Widget build(BuildContext context) {

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
                  minimumSize: const Size(double.infinity, 0),
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
