import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart';
import 'package:face_gate/aws/aws_verify_model.dart';
import 'package:face_gate/utils/utils.dart';

class AWSValidationBloc {
  String accessKey = 'AKIAQ4HZK7VKBCF5JMBN';
  String secretKey = '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';
  String region = 'us-east-1';

  Future<AWSVerifyModel> validateUser({String? imagePath1}) async {
    Uint8List bytes1 = File(imagePath1!).readAsBytesSync();
    Uint8List bytes2 = getSetImage.getImage();

    Rekognition rekognition = Rekognition(
        region: region,
        credentials:
            AwsClientCredentials(accessKey: accessKey, secretKey: secretKey));
    CompareFacesResponse response = await rekognition.compareFaces(
        sourceImage: Image(bytes: bytes1), targetImage: Image(bytes: bytes2));
    AWSVerifyModel model = AWSVerifyModel(response);
    return model;
  }
}
