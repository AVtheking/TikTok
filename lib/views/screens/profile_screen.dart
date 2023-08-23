import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/error_text.dart';
import 'package:tiktok_clone/utl.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});
  void signOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? loader()
        : ref.watch(userDataProvider(uid)).when(
              data: (user) => Scaffold(
                appBar: AppBar(
                  backgroundColor: backgroundColor,
                  leading: const Icon(Icons.person_add_alt_1_outlined),
                  actions: const [Icon(Icons.more_horiz)],
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: Column(children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.profilePic,
                              ),
                              radius: 50,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Following",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 15,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Followers",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 15,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Likes",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              signOut(ref);
                            },
                            child: Text(
                              "Sign out",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ]),
                ),
              ),
              error: (error, stackTrace) => ErrorText(
                text: error.toString(),
              ),
              loading: () => loader(),
            );
  }
}
