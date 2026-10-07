import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController messageController;
  final String text;
  MessageTextField({
    super.key,
    required this.messageController,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 0, 30),
      child: TextField(
        controller: messageController,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
