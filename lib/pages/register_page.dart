import 'package:chat_app/widgets/login_register_page/continue_with_text.dart';
import 'package:chat_app/widgets/login_register_page/sign_in_button.dart';
import 'package:chat_app/widgets/login_register_page/square_tile.dart';
import 'package:chat_app/widgets/login_register_page/user_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //User tapped SignIn Button
  void SignUserUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      showMessage("Passwords don't match!");
      return;
    }
    final navigator = Navigator.of(context, rootNavigator: true);

    //show loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    //try creating using user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                height: 330,
                child: Image.asset("assets/images/Register.png", fit: .fill),
              ),

              //welcome back text
              Text(
                "Let's create an account for you.",
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
              //confirm password
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 8),
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                  obscureText: true,
                  obscuringCharacter: "*",
                ),
              ),

              //sign in button
              SignInButton(text: "Sign Up", onTap: SignUserUp),

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
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
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
