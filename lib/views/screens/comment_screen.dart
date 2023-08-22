import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/video_controller.dart';

class CommentsScreen extends ConsumerWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    void addComment() async {
      ref.watch(videoControllerProvider.notifier).addComment(
          postId: postId, text: textController.text.trim(), context: context);
    }

    return Scaffold(
      body: Column(
        children: [
         

              ref.watch(commentProvider(postId)).when(data: (data)=>Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final comment=data[index];
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
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "10 likes",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.favorite),
                  );
                }),
          ),, error: error, loading: loading)
 
          const Divider(),
          ListTile(
            title: TextFormField(
              controller: textController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
              child: Text(
                'Send',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
