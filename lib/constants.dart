import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/add_post_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';

var backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
var borderColor = Colors.grey;

class Constants {
  static const pages = [
    VideoScreen(),
    Text("search Screen"),
    AddPostScreen(),
    Text("mesxsage Screen"),
    Text("profile Screen"),
  ];
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
}
