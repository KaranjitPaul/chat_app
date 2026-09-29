import 'package:chat_app/widgets/loginPage/continue_with_text.dart';
import 'package:chat_app/widgets/loginPage/sign_in_button.dart';
import 'package:chat_app/widgets/loginPage/square_tile.dart';
import 'package:chat_app/widgets/loginPage/user_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //User tapped SignIn Button
  void signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            //Logo/Welcome Banner
            Expanded(child: Image.asset("assets/images/login.png")),

            //welcome back text
            Text(
              "Welcome Back! You've been missed!",
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: .bold,
                fontSize: 16,
              ),
            ),

            //User input field
            UserInputField(
              emailController: emailController,
              passwordController: passwordController,
            ),

            //forgot password?
            Container(
              alignment: .topEnd,
              padding: EdgeInsets.only(right: 18),
              child: Text(
                "Forget Password?",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            //sign in button
            SignInButton(onTap: signIn),

            //or continue with
            ContinueWithText(),

            //google + apple sign in button
            Row(
              mainAxisAlignment: .center,
              children: [
                SquareTile(imagePath: "assets/images/Google.png"),
                SquareTile(imagePath: "assets/images/Apple.png"),
              ],
            ),

            //not a member? register now
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 40),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text("Not a member? "),
                  Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
