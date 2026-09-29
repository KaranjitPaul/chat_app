import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/utils/routes.dart';
import 'package:chat_app/utils/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: MyRoutes.loginPage,
      routes: {MyRoutes.loginPage: (context) => LoginPage()},
    );
  }
}
