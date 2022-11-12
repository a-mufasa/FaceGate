import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app_title = "Facegate";
    return MaterialApp(title: app_title, home: RegisterView());
  }
}
