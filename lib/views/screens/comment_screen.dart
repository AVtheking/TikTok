import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/controller/video_controller.dart';
import 'package:tiktok_clone/error_text.dart';
import 'package:tiktok_clone/utl.dart';
// import 'package:timeago/timeago.dart' as tago;

class CommentsScreen extends ConsumerStatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreen();
}

class _CommentsScreen extends ConsumerState<CommentsScreen> {
  final TextEditingController textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    void addComment() async {
      ref.watch(videoControllerProvider.notifier).addComment(
          postId: widget.postId,
          text: textController.text.trim(),
          context: context);
      textController.text = '';
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: ref.watch(commentProvider(widget.postId)).when(
                    data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final comment = data[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(comment.profilePic),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.username,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                Text(
                                  comment.comment,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      comment.createdAt.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${comment.likes} likes',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.favorite),
                          );
                        }),
                    error: (error, stackTrace) => ErrorText(
                      text: error.toString(),
                    ),
                    loading: () => loader(),
                  ),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: textController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              trailing: TextButton(
                onPressed: addComment,
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
