import 'dart:io';

import 'package:face_gate/aws/aws_face_comparison.dart';
import 'package:face_gate/resources/auth_methods.dart';
import 'package:face_gate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import 'data/user.dart';

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
          child: ScanPageViewContent(
              firstName: firstName,
              lastName: lastName,
              password: password,
              dbImage: dbImage),
        ));
  }
}

class ScanPageViewContent extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? password;
  Uint8List? dbImage;

  ScanPageViewContent(
      {this.firstName, this.lastName, super.key, this.dbImage, this.password});

  @override
  State<ScanPageViewContent> createState() => _ScanPageViewContentState();
}

class _ScanPageViewContentState extends State<ScanPageViewContent> {
  void startReadingNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    NfcManager.instance.startSession(
      onError: (error) async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: Text('$error '),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      onDiscovered: (NfcTag tag) async {
        late var user;

        var id = tag.data['nfca']['identifier'].toString();
        NfcManager.instance.stopSession();

        if (widget.firstName == null) {
          if (id != getSetNfc.getTag()) {
            return;
          }
          user = await AuthMethods().loginUser();
          bool existingTag = getSetNfc.getTag() == id;
          for (var i = 0; i < user['nfcTags'].length; i++) {
            if (user.nfcTags[i] == id) {
              existingTag = true;
              NfcManager.instance.stopSession();
              //this is where unlock validation route goes
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Alert'),
                    content: const Text("NFC Read!"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }

          if (existingTag == false) {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: const Text("NFC added!"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          getSetNfc.setTag(id);
          user = User(widget.firstName!, widget.lastName!, widget.dbImage!,
              widget.password!, []);
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text("User Signed up!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        var existingTag = id == getSetNfc.getTag();
        print(existingTag);

        if (existingTag == false) {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text("NFC added!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      user.nfcTags.add(id);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        // await AuthMethods().signUpUser(user: user);
        final newRoute =
            MaterialPageRoute(builder: (context) => AwsFaceComparison());
        Navigator.push(context, newRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('assets/wifi_symbol.png')),
        ElevatedButton(
          child: const Text('Scan a lock!'),
          onPressed: () {
            if (Platform.isIOS) {
              final newRoute =
                  MaterialPageRoute(builder: (context) => AwsFaceComparison());
              Navigator.push(context, newRoute);
            } else {
              startReadingNFC();
            }
          },
        ),
      ],
    );
  }
}
