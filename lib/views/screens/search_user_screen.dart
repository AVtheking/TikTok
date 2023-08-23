import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/error_text.dart';
import 'package:tiktok_clone/utl.dart';

class SearchScreen extends ConsumerStatefulWidget {
  SearchScreen({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreem();
}

class _SearchScreem extends ConsumerState<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigateToProfileScreen(String uid) {
    Routemaster.of(context).push('/profile_screen/$uid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        leading: Icon(Icons.search),
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: buttonColor,
              hintText: "Search",
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
      body: ref
          .watch(
            searchUserProvider(
              controller.text.trim(),
            ),
          )
          .when(
              data: (data) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        final user = data[index];
                        return InkWell(
                          onTap: () {
                            navigateToProfileScreen(user.uid);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePic),
                            ),
                            title: Text(user.name),
                          ),
                        );
                      }),
                    ),
                  ),
              error: (error, stackTrace) => ErrorText(
                    text: error.toString(),
                  ),
              loading: () => loader()),
    );
  }
}
