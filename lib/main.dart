import 'package:face_gate/resources/auth_methods.dart';
import 'package:face_gate/scan_page_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var test = await AuthMethods().loginUser();
  bool isActive = test != null;
  runApp(MyApp(isActive));
}

class MyApp extends StatelessWidget {
  bool isActive;
  MyApp(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    final app_title = "Facegate";
    if (!isActive) {
      return MaterialApp(title: app_title, home: RegisterView());
    } else {
      return MaterialApp(title: app_title, home: ScanPageView());
    }
  }
}
