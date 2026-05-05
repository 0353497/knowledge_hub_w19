import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.index,
    required this.icon,
    required this.title,
  });
  final int index;
  final IconData icon;
  final String title;

  @override
  State<VideoPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<VideoPage> {
  VideoPlayerController controller = VideoPlayerController.asset(
    "assets/media-files/K1_Management/Management.mp4",
  );

  @override
  void initState() {
    super.initState();

    controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(children: [Text(widget.title), Icon(widget.icon)]),
            VideoPlayer(controller),
            VideoButton(icon: Icons.play_arrow, text: 'Play', onTap: () {}),
            VideoButton(icon: Icons.pause, text: 'Pause', onTap: () {}),
            VideoButton(icon: Icons.replay, text: 'Replay', onTap: () {}),
            VideoButton(icon: Icons.keyboard_tab, text: 'Next', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class VideoButton extends StatelessWidget {
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .5,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Icon(icon), Text(text)]),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
