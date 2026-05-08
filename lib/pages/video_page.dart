import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'quiz_page.dart';

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
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController controller;

  String _getVideoPath(int index) {
    const videoFolders = [
      'K1_Management',
      'K2_About_the_Venue',
      'K3_Public_Art',
      'K4_Facilities',
      'K5_Dining&Catering',
    ];

    const videoFiles = [
      'Management.mp4',
      'About_the_Venue.mp4',
      'Public_Art.mp4',
      'Facilities.mp4',
      'Dining&Catering.mp4',
    ];

    if (index >= 0 && index < videoFolders.length) {
      return 'assets/media-files/${videoFolders[index]}/${videoFiles[index]}';
    }
    return 'assets/media-files/K1_Management/Management.mp4';
  }

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(_getVideoPath(widget.index));
    controller.initialize();
    controller.setLooping(false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _playVideo() {
    controller.play();
  }

  void _pauseVideo() {
    controller.pause();
  }

  void _replayVideo() {
    controller.seekTo(Duration.zero);
    controller.play();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Replay'), duration: Duration(seconds: 1)),
    );
  }

  void _nextPage() {
    Get.to(
      () =>
          QuizPage(index: widget.index, icon: widget.icon, title: widget.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 32, color: Colors.blue),
                  const SizedBox(width: 12),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: controller.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              VideoButton(
                icon: Icons.play_arrow,
                text: 'Play',
                onTap: _playVideo,
              ),
              VideoButton(icon: Icons.pause, text: 'Pause', onTap: _pauseVideo),
              VideoButton(
                icon: Icons.replay,
                text: 'Replay',
                onTap: _replayVideo,
              ),
              VideoButton(
                icon: Icons.arrow_forward,
                text: 'Next',
                onTap: _nextPage,
              ),
            ],
          ),
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
        onPressed: () {
          onTap.call();
        },
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
