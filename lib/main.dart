import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fkxpzsvspzkmfcuahzqa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZreHB6c3ZzcHprbWZjdWFoenFhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxMDM5MjQsImV4cCI6MjA1NDY3OTkyNH0.3DY-n_-UvezAYGRC9vXxGBO3-RzvzPe7rqCvodEkemE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}
