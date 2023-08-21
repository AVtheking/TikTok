import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});
  pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
              videoFile: File(video.path), videoPath: video.path)));
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  pickVideo(ImageSource.gallery, context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.cancel),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showOptionDialog(context),
      child: Container(
        width: 190,
        height: 50,
        decoration: BoxDecoration(color: buttonColor),
        child: const Center(
          child: Text(
            'Add Video',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
