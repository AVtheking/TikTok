import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController songController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  // Initialize the controller asynchronously
  Future<void> initializeController() async {
    controller = VideoPlayerController.file(widget.videoFile);
    await controller.initialize();
    setState(() {
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: VideoPlayer(controller),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputField(
                          controller: songController,
                          labelText: "Song name",
                          icon: Icons.music_note),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputField(
                          controller: songController,
                          labelText: "Caption",
                          icon: Icons.closed_caption),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Share!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
