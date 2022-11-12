import 'package:flutter/material.dart';

class register_view extends StatelessWidget{

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: Center(
            child: Text("Hello Worlds!"),
          )),
    );
  }


}