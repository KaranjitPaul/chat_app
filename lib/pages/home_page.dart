import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:chat_app/widgets/home_drawer.dart';
import 'package:chat_app/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(fontWeight: .w500, fontSize: 25, letterSpacing: 2),
        ),
        actionsPadding: EdgeInsets.only(right: 15),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildUserList(),
      ),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //build indicidual list tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    //display all user except current user
    if (userData["email"] != _authServices.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //tapped on a user -> go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(receiverEmail: userData["email"]),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
