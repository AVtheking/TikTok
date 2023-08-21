import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/utl.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends ConsumerState<SignUpScreen> {
  File? profilePic;
  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profilePic = File(res.files.first.path!);
      });
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void signInUser(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController usernameController,
    TextEditingController passwordContoller,
    WidgetRef ref,
  ) {
    ref.watch(authControllerProvider.notifier).signInUser(
        userName: usernameController.text,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
        file: profilePic);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tiktok Clone",
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    profilePic != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(profilePic!),
                            radius: 65,
                          )
                        : const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                            radius: 65,
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: selectProfileImage,
                            icon: const Icon(Icons.add_a_photo)))
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: usernameController,
                      icon: Icons.person,
                      labelText: "Username",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: emailController,
                      icon: Icons.email_sharp,
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: passwordController,
                      icon: Icons.password_sharp,
                      labelText: "Password",
                      isObscure: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor),
                      onPressed: () {
                        signInUser(context, emailController, usernameController,
                            passwordController, ref);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(color: buttonColor, fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
