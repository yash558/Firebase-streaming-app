import 'package:flutter/material.dart';
import 'package:livestreamingapp/screens/login_screen.dart';
import 'package:livestreamingapp/screens/signup_screen.dart';
import 'package:livestreamingapp/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = "/boarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                "Streaming App",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomButton(
                  text: "Log in",
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }),
            ),
            CustomButton(
                text: "Sign Up",
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                })
          ],
        ),
      ),
    );
  }
}
