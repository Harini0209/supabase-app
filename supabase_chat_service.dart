import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseChatService {
  final _supabase = Supabase.instance.client;

  // Send a message
  Future<void> sendMessage(String content) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("Not logged in");

    await _supabase.from("messages").insert({
      "sender_id": user.id,
      "content": content,
    });
  }

  // Fetch latest messages
  Future<List<Map<String, dynamic>>> fetchMessages() async {
    final response = await _supabase
        .from("messages")
        .select("id, sender_id, content, created_at")
        .order("created_at", ascending: true);
    return response;
  }

  // Subscribe to real-time messages
  Stream<List<Map<String, dynamic>>> subscribeMessages() {
    return _supabase
        .from("messages")
        .stream(primaryKey: ["id"])
        .order("created_at")
        .map((event) => event);
  }
}
