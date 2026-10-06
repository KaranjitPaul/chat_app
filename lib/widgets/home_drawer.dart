import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String email = user?.email ?? 'No email address';
    final String name = user?.displayName ?? email.split('@').first;
    final String? photoUrl = user?.photoURL;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundImage: photoUrl == null
                      ? null
                      : NetworkImage(photoUrl),
                  child: photoUrl == null
                      ? Text(
                          name.isEmpty ? '?' : name[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(email, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        horizontalTitleGap: 20,
                        leading: const Icon(Icons.home, size: 30),
                        title: const Text(
                          'Home',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {},
                      ),

                      ListTile(
                        horizontalTitleGap: 20,
                        leading: const Icon(Icons.settings, size: 30),
                        title: const Text(
                          'Settings',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ListTile(
                    horizontalTitleGap: 20,
                    leading: const Icon(Icons.logout, size: 30),
                    title: const Text(
                      'Sign out',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
