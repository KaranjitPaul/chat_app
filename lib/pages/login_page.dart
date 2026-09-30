import 'package:chat_app/widgets/loginPage/continue_with_text.dart';
import 'package:chat_app/widgets/loginPage/sign_in_button.dart';
import 'package:chat_app/widgets/loginPage/square_tile.dart';
import 'package:chat_app/widgets/loginPage/user_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //User tapped SignIn Button
  void signIn() async {
    final navigator = Navigator.of(context, rootNavigator: true);

    //show loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading animation
      navigator.pop();
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      if (e.code == "user-not-found") {
        wrongEmailMessage();
      } else if (e.code == "wrong-password") {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(title: Text("Wrong Password"));
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(title: Text("Incorrect Password"));
      },
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
