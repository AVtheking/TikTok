import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login(WidgetRef ref, BuildContext context) {
    ref.watch(authControllerProvider.notifier).loginInUser(
        emailController.text.trim(), passwordController.text.trim(), context);
  }

  void navigateToSignUpScreen(BuildContext context) {
    Routemaster.of(context).push('/sign_up_screen');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
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
              "Login",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
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
              height: 30,
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
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                onPressed: () {
                  login(ref, context);
                },
                child: const Text(
                  "Login",
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
                  "Don't have an account?",
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    navigateToSignUpScreen(context);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: buttonColor, fontSize: 20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
