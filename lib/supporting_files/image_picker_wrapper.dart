import 'dart:io';
import 'package:face_gate/supporting_files/file_picker_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef ImagePickerResult = void Function(FilePickerWrapperResult result);

class ImagePickerWrapper {
  ImagePickerWrapper(
      {required ImagePickerResult imagePickerResult,
      double maxFileSizeAllowed = 2024 //size in kb
      }) {
    _imagePickerResult = imagePickerResult;
    _maxFileSizeAllowed = maxFileSizeAllowed;
  }
  ImagePickerResult? _imagePickerResult;
  double? _maxFileSizeAllowed;

  void openImagePicker({BuildContext? buildContext}) {
    if (buildContext == null) {
      print("build content can't be empty");
      return;
    }
    _openCamera(ImageSource.camera);
  }

  Future<void> _openCamera(ImageSource source) async {
    XFile? imageSelected = await ImagePicker()
        .pickImage(source: source, maxHeight: 400, maxWidth: 400);
    final String fileName = imageSelected!.path.split('/').last;
    if (_maxFileSizeAllowed! < await imageSelected.length() / 1024) {
      String message =
          'File size exceeded. Maximum file size allowed($_maxFileSizeAllowed kB)';
      _imagePickerResult!(
          FilePickerWrapperFailedResult(errorMessage: message, code: 0));
    }
    _imagePickerResult!(FilePickerWrapperSuccessResult(
        code: 1, filePath: imageSelected.path, fileName: fileName));
  }
}
