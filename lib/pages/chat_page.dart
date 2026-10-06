import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;

  const ChatPage({super.key, required this.receiverEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(receiverEmail)));
  }
}
