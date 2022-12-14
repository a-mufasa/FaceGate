import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:face_gate/aws/aws_face_comparison.dart';
import 'package:face_gate/resources/auth_methods.dart';
import 'package:face_gate/scan_page_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'form_view.dart';
import 'register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app_title = "Facegate";

    return MaterialApp(title: app_title, home: RegisterView());
  }
}
