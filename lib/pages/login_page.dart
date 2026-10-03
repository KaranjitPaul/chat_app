import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/login_register_page/continue_with_text.dart';
import 'package:chat_app/widgets/login_register_page/sign_in_button.dart';
import 'package:chat_app/widgets/login_register_page/square_tile.dart';
import 'package:chat_app/widgets/login_register_page/user_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

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
      showMessage(e.code);
    }
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              //Logo/Welcome Banner
              SizedBox(
                height: 350,
                child: Image.asset("assets/images/login.png", fit: .cover),
              ),

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
              SignInButton(text: "Sign In", onTap: signIn),

              //or continue with
              ContinueWithText(),

              //google + apple sign in button
              Row(
                mainAxisAlignment: .center,
                children: [
                  SquareTile(
                    imagePath: "assets/images/Google.png",
                    onTap: () => AuthServices().signInWithGoogle(),
                  ),
                  SquareTile(
                    imagePath: "assets/images/Apple.png",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Feature not yet added!"),
                          backgroundColor: Colors.grey[700],
                        ),
                      );
                    },
                  ),
                ],
              ),

              //not a member? register now
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 40),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text("Not a member? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
