import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_gate/data/user.dart';
import 'package:face_gate/resources/storage_methods.dart';
import 'package:flutter/material.dart';
// import 'package:device_info/device_info.dart';
import 'dart:io';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String identifier = "fifth";

  Future<String> signUpUser({required User user
      //   required String firstName,
      // required String lastName,
      // required Uint8List photo,
      // required String password,
      // required List<String> nfcTags
      }) async {
    String res = "Error.";
    try {
      // if (Platform.isAndroid) {
      //   var build = await deviceInfoPlugin.androidInfo;
      //   identifier = build.androidId.toString();
      // } else if (Platform.isIOS) {
      //   var data = await deviceInfoPlugin.iosInfo;
      //   identifier = data.identifierForVendor.toString();
      // } else {
      //   return res;
      // }

      String photoURL = await StorageMethods()
          .uploadImageToStorage('profileImage', user.photo);
      // add user to db
      await _firestore.collection('users').doc(identifier).set({
        'serialNumber': identifier,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'password': user.password,
        'nfcTags': user.nfcTags,
        'photoURL': photoURL
      });
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
