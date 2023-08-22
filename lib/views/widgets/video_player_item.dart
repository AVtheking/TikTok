import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoURl;
  const VideoPlayerItem({super.key, required this.videoURl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoController;
  @override
  @override
  void initState() {
    super.initState();
    initializeController();
  }

  // Initialize the controller asynchronously
  Future<void> initializeController() async {
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURl));
    await videoController.initialize();
    setState(() {
      videoController.play();
      videoController.setVolume(1);
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoController),
    );
  }
}
