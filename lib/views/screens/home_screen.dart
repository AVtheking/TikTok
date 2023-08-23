import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/views/screens/add_post_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_user_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int pageInd = 0;
  Widget navigateScreens(WidgetRef ref, int pageInd) {
    final user = ref.watch(userProvider)!;

    List pages = [
      const VideoScreen(),
      SearchScreen(),
      const AddPostScreen(),
      const Text("mesxsage Screen"),
      ProfileScreen(uid: user.uid),
    ];
    return pages[pageInd];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageInd,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              pageInd = index;
            });
          },
          backgroundColor: backgroundColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 30,
              ),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile',
            ),
          ]),
      body: Center(child: navigateScreens(ref, pageInd)),
    );
  }
}
