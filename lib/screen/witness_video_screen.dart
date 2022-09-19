import 'package:flutter/material.dart';
import 'package:sw_hackathon_2022/widget/video_controller_overlay.dart';
import 'package:video_player/video_player.dart';


class WitnessVideoScreen extends StatefulWidget {
  const WitnessVideoScreen({Key? key, required this.heroTag}) : super(key: key);
  final String heroTag;
  @override
  State<WitnessVideoScreen> createState() => _WitnessVideoScreenState();
}

class _WitnessVideoScreenState extends State<WitnessVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('assets/witness_video.mp4');
    _videoPlayerController.addListener(() {
      setState(() {
      });
    });
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    _videoPlayerController.setLooping(false);
    super.initState();
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Hero(
                tag: 'witness video1',
                child: Material(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_videoPlayerController),
                        VideoProgressIndicator(_videoPlayerController, allowScrubbing: true),
                        ControlsOverlay(controller: _videoPlayerController),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
