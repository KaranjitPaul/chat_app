import 'package:flutter/material.dart';

class ContinueWithText extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
          Text(
            "Or continue with",
            style: TextStyle(color: Colors.grey[800], fontWeight: .w400),
          ),
          Expanded(child: Divider(thickness: 0.5, color: Colors.grey[500])),
        ],
      ),
    );
  }
}
