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

class getSetImage {
  static Uint8List image = ByteData(1) as Uint8List;
  static Uint8List getImage() {
    return image;
  }

  static void setImage(Uint8List image2) {
    image = image2;
  }
}
