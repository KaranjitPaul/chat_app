import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/message_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  //send message
  void sendMessage() async {
    //if there is something inside the text
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatServices.sendMessage(receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(child: _buildMessageList()),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build messagge list
  Widget _buildMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(senderID, receiverID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          Center(child: CircularProgressIndicator());
        }

        //return listview
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser()!.uid;

    //align messages to the right side if sender is the current user, otherwise to the left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Row(
      crossAxisAlignment: .center,
      children: [
        //text field should take most of the space
        Expanded(
          child: MessageTextField(
            messageController: _messageController,
            text: "Write your message",
          ),
        ),

        //send button
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.arrow_circle_up_outlined, size: 50),
          ),
        ),
      ],
    );
  }
}
