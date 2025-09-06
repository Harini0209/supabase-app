import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final Timestamp timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  // Factory constructor to create a ChatMessage from a Firestore document
  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'] as String,
      senderId: doc['senderId'] as String,
      timestamp: doc['timestamp'] as Timestamp,
    );
  }

  // Method to convert a ChatMessage to a JSON-like map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }
}
