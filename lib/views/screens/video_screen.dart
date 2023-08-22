import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/controller/video_controller.dart';
import 'package:tiktok_clone/error_text.dart';
import 'package:tiktok_clone/models/postVideo.dart';
import 'package:tiktok_clone/utl.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/widgets/video_player_item.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    buildMusicAlbum(String profilePhoto) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.grey, Colors.white]),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      );
    }

    void likingPost(PostVideo post) async {
      ref.watch(videoControllerProvider.notifier).likingPost(post);
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ref.watch(postedVideoProvider).when(
              data: (data) => PageView.builder(
                  itemCount: data.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final post = data[index];
                    return Stack(
                      children: [
                        VideoPlayerItem(videoURl: post.videoUrl),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Text(
                                post.userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                post.caption,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.music_note,
                                    size: 15,
                                  ),
                                  Text(
                                    post.songName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(
                              top: size.height * 0.35, left: size.width * 0.75),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors
                                        .white, // Set the desired border color
                                    width: 2.0, // Set the desired border width
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(post.profilePhoto),
                                    radius: 25,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      likingPost(post);
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    post.likes.length.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.comment,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    post.commentCount.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.reply,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    post.shareCount.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum(post.profilePhoto),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
              error: (error, stackTrace) => ErrorText(
                text: error.toString(),
              ),
              loading: () => loader(),
            ));
  }
}
