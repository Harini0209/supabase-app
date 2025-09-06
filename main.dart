import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: "https://jgmjmysgvcaykezrdzwt.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpnbWpteXNndmNheWtlenJkend0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcwNjA3ODgsImV4cCI6MjA3MjYzNjc4OH0.5vDgT3p336EPVocLhLlk-JGGMdRjBHAueAiXtLWEaSw",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Supabase Chat App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: AppRouter.router,
    );
  }
}
