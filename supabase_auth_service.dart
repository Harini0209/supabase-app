import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService {
  Future<User?> signUp(String email, String password, String name) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user != null) {
      await supabase.from('profiles').insert({
        'id': user.id,
        'name': name,
        'email': email,
        'avatar_url': '',
      });
    }
    return user;
  }

  Future<User?> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;

  Stream<User?> get authStateChanges =>
      supabase.auth.onAuthStateChange.map((data) => data.session?.user);
}
