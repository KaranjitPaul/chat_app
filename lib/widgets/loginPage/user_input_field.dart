import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const UserInputField({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      child: Column(
        spacing: 10,
        children: [
          //username textfield
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: "Username",
              hintStyle: TextStyle(color: Colors.grey[500]),
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
          ),

          //Password textfield
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
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
        ],
      ),
    );
  }
}
