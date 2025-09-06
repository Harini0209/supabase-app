import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../services/supabase_auth_service.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;
  const ProtectedRoute({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    if (user == null) {
      return LoginScreen();
    }
    return child;
  }
}
