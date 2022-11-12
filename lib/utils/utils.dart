import 'package:face_gate/resources/auth_methods.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('no image');
}

Future<Uint8List> getImage() async {
  var user = await AuthMethods().loginUser();
  var imageUrl = user?['photoURL'];
  Uint8List bytes =
      (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
          .buffer
          .asUint8List();
  return bytes;
}
