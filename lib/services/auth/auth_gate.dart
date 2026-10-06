import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is loggged in
          if (snapshot.hasData) {
            //user not logged in
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
