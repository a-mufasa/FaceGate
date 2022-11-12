import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';

class ScanPageView extends StatelessWidget {
  String? firstName;
  String? lastName;
  String? password;
  Uint8List? dbImage;

  ScanPageView(
      {this.firstName, this.lastName, this.dbImage, this.password, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Facegate'),
        ),
        body: Center(
          child: ScanPageViewContent(firstName: firstName, lastName: lastName),
        ));
  }
}

class NFCObject {
  String name;
  String id;

  NFCObject(this.id, this.name);
}

class ScanPageViewContent extends StatefulWidget {
  String? firstName;
  String? lastName;
  Uint8List? dbImage;

  ScanPageViewContent({this.firstName, this.lastName, super.key, this.dbImage});

  @override
  State<ScanPageViewContent> createState() => _ScanPageViewContentState();
}

class _ScanPageViewContentState extends State<ScanPageViewContent> {
  void startReadingNFC() async {
    // bool isAvailable = await NfcManager.instance.isAvailable();

    // NfcManager.instance.startSession(
    //   onDiscovered: (NfcTag tag) async {
    //     // Do something with an NfcTag instance.

    //     //checking if we came from the register page or existing user page:

    //     //query database for firstname if firstname doesn't already exist
    //     if (widget.firstName == null) {
    //       //query database by unique phone id!
    //     }

    //     NfcManager.instance.stopSession();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('assets/wifi_symbol.png')),
        ElevatedButton(
          child: const Text('Scan a lock!'),
          onPressed: () {
            startReadingNFC();
          },
        ),
      ],
    );
  }
}
