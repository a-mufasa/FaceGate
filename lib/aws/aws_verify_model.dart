import 'package:aws_rekognition_api/rekognition-2016-06-27.dart';

class AWSVerifyModel {
  bool matchResult = false;
  String? confidence;
  int? totalFacesFoundInTargetImage;
  String? message;

  AWSVerifyModel(CompareFacesResponse response) {
    List<CompareFacesMatch>? matchedFaces = response.faceMatches;
    List<ComparedFace>? unmatchedFaces = response.unmatchedFaces;

    if (matchedFaces != null && matchedFaces.isNotEmpty) {
      message = 'Verified';
      matchResult = true;
      confidence = matchedFaces.last.similarity?.toStringAsFixed(2);
    } else {
      message = 'Failed: No matched face found.';
    }
  }
}
