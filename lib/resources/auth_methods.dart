import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:face_gate/data/user.dart';
import 'package:face_gate/resources/storage_methods.dart';
import 'dart:io';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    var mac = "";
    if (Platform.isIOS) {
      var tmp = await deviceInfo.iosInfo;
      mac = tmp.identifierForVendor.toString();
    } else if (Platform.isAndroid) {
      mac = "Android";
    }
    return mac;
  }

  // post current object
  Future<String> signUpUser({required User user}) async {
    String res = "Error.";
    try {
      String identifier = await getDeviceId();

      String photoURL = await StorageMethods()
          .uploadImageToStorage('profileImage', identifier, user.photo);
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

  // get current object
  Future<Map<String, dynamic>?> loginUser() async {
    try {
      String identifier = await getDeviceId();
      if (identifier.isNotEmpty) {
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(identifier).get();
        return (snap.data() as Map<String, dynamic>);
      }
    } catch (err) {}
    return <String, dynamic>{};
  }
}
