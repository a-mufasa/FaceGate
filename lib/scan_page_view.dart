import 'package:flutter/material.dart';
import 'dart:typed_data';

class ScanPageView extends StatelessWidget {
  String firstName;
  String lastName;
  Uint8List? dbImage;

  //in the event none is given, we query the database for the above values

  // ScanPageView.fromDatabase() {}

  //TODO: Change from optional to mandatory after implementing picture selector for app
  ScanPageView(this.firstName, this.lastName, {super.key, this.dbImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Facegate'),
        ),
        body: Center(
          child: ScanPageViewContent(firstName, lastName),
        ));
  }
}

class ScanPageViewContent extends StatefulWidget {
  String firstName;
  String lastName;
  Uint8List? dbImage;

  ScanPageViewContent(this.firstName, this.lastName, {super.key, this.dbImage});

  @override
  State<ScanPageViewContent> createState() => _ScanPageViewContentState();
}

class _ScanPageViewContentState extends State<ScanPageViewContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('assets/wifi_symbol.png')),
        ElevatedButton(
          child: const Text('Add a new lock!'),
          onPressed: () {},
        ),
      ],
    );
  }
}
