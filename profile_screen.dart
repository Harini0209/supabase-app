import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'chats_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ProfileScreen({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${profile['name']}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(profile['avatar_url']),
            ),
            const SizedBox(height: 16),
            Text("Name: ${profile['name']}"),
            Text("Email: ${profile['email']}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
              child: const Text("Settings"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatsScreen()),
              ),
              child: const Text("Chats"),
            ),
          ],
        ),
      ),
    );
  }
}
