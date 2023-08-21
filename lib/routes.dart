import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => MaterialPage(
          child: LoginScreen(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: HomeScreen(),
        ),
  },
);
