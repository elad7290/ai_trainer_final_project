import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'clipper_widget.dart';

class WaveWidget extends StatefulWidget {

  final Size size;
  final double yOffset;
  final Color color;

  const WaveWidget({super.key, required this.size, required this.yOffset, required this.color});

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin{

  late AnimationController animationController;
  List<Offset> wavePoints = []; // offset = (x,y) coordinates

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000))
      ..addListener(() {
        wavePoints.clear();
        final double waveSpeed = animationController.value * 1080;
        final double fullSphere = animationController.value * math.pi * 2;
        final double normalizer = math.cos(fullSphere); // values between -1 to 1
        const double waveWidth = math.pi / 270;
        const double waveHeight = 20.0;

        for (int i=0; i<= widget.size.width.toInt(); i++){
          double calc = math.sin((waveSpeed - i) * waveWidth);
          wavePoints.add(
            Offset(
              i.toDouble(),
              calc * waveHeight * normalizer + widget.yOffset,
            ),
          );
        }
      });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
              waveList: wavePoints
          ),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
