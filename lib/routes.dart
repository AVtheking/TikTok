import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/sign_in_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => MaterialPage(
          child: LoginScreen(),
        ),
    '/sign_up_screen': (_) => const MaterialPage(
          child: SignUpScreen(),
        ),
    '/login_screen': (_) => MaterialPage(
          child: LoginScreen(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: HomeScreen(),
        ),
    '/comment_screen/:post': (route) => MaterialPage(
          child: CommentsScreen(postId: route.pathParameters['post']!),
        ),
    '/profile_screen/:userid': (route) => MaterialPage(
          child: ProfileScreen(uid: route.pathParameters['userid']!),
        ),
  },
);
