import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/error_text.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;

    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateProvider).when(
        data: (data) => MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData.dark()
                  .copyWith(scaffoldBackgroundColor: backgroundColor),
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    // print(userModel!.name);
                    return loggedInRoute;
                  }
                }
                // print('here');
                return loggedOutRoute;
              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: ((error, stackTrace) => ErrorText(
              text: error.toString(),
            )),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
