import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final List<Map<String, String>> chatUsers = [
    {"name": "Alice", "lastMessage": "Hey, how are you?", "avatar": ""},
    {"name": "Bob", "lastMessage": "See you tomorrow!", "avatar": ""},
    {"name": "Charlie", "lastMessage": "Can we meet?", "avatar": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: ListView.builder(
        itemCount: chatUsers.length,
        itemBuilder: (context, index) {
          final user = chatUsers[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: user['avatar']!.isNotEmpty
                  ? null
                  : Text(
                      user['name']![0],
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
            title: Text(
              user["name"] ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200], // bubble background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user["lastMessage"] ?? "",
                style: const TextStyle(color: Colors.black87),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatRoomScreen(userName: user["name"]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ---------------- Chat Room Screen with auto-reply ----------------
class ChatRoomScreen extends StatefulWidget {
  final String userName;

  const ChatRoomScreen({required this.userName, Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> messages = []; // Stores message + sender

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add your message
    setState(() {
      messages.add({'sender': 'me', 'text': text});
    });
    _messageController.clear();

    // Simulate a reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'sender': 'them',
          'text': "Reply from ${widget.userName} to: $text",
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with ${widget.userName}")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final msg = messages[index];
                final isMe = msg['sender'] == 'me';

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blueAccent : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
