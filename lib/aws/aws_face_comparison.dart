import 'dart:io';
import 'dart:typed_data';
import 'package:aws_rekognition_api/rekognition-2016-06-27.dart' as aws;
import 'package:face_gate/aws/aws_validation_bloc.dart';
import 'package:face_gate/aws/aws_verify_model.dart';
import 'package:face_gate/supporting_files/file_picker_wrapper.dart';
import 'package:face_gate/supporting_files/image_picker_wrapper.dart';
import 'package:face_gate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AwsFaceComparison extends StatefulWidget {
  @override
  _AwsFaceComparisonState createState() => _AwsFaceComparisonState();
}

class _AwsFaceComparisonState extends State<AwsFaceComparison> {
  final AWSValidationBloc _bloc = AWSValidationBloc();

  int choosingImageForTile = 0;
  ImagePickerWrapper? _imagePickerWrapper;

  String? image1Path;
  String? image2Path;

  final PublishSubject<FilePickerWrapperSuccessResult> _image1Status =
      PublishSubject<
          FilePickerWrapperSuccessResult>(); //false- means failed, true- success
  Stream<FilePickerWrapperSuccessResult> get image1Stream =>
      _image1Status.stream;

  final PublishSubject<FilePickerWrapperSuccessResult> _image2Status =
      PublishSubject<
          FilePickerWrapperSuccessResult>(); //false- means failed, true- success
  Stream<FilePickerWrapperSuccessResult> get image2Stream =>
      _image2Status.stream;

  final PublishSubject<AWSVerifyModel> _verifyResult =
      PublishSubject<AWSVerifyModel>(); //false- means failed, true- success
  Stream<AWSVerifyModel> get verifyResultStream => _verifyResult.stream;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(image1Stream, image2Stream, (a, b) {
        return true;
      });

  @override
  void initState() {
    _imagePickerWrapper =
        ImagePickerWrapper(imagePickerResult: handleImageResultFunction);

    image1Stream.listen((data) {
      image1Path = data.filePath;
    });
    // image2Stream.listen((data) {
    //   image2Path = data.filePath;
    // });

    super.initState();
  }

  void handleImageResultFunction(FilePickerWrapperResult result) {
    print(result.code);
    if (result is FilePickerWrapperSuccessResult) {
      print(result.filePath);
      if (choosingImageForTile == 0) {
        _image1Status.sink.add(result);
      }
    } else if (result is FilePickerWrapperFailedResult) {
      print('${result.errorMessage} — -');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getResultWidget(),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getImageContainer(stream: image1Stream, index: 0),
                  ],
                ),
              ),
              validateButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget getResultWidget() {
    return StreamBuilder<AWSVerifyModel>(
        stream: verifyResultStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Color color = Colors.white;
            if (!snapshot.data!.matchResult) {
              color = Colors.red;
            } else {
              color = Colors.green;
            }

            return Container(
              margin: const EdgeInsets.all(15),
              child: Text(
                snapshot.data?.matchResult == true
                    ? '${snapshot.data!.message} \nConfidence : ${snapshot.data!.confidence}'
                    : '${snapshot.data!.message}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget validateButton() {
    return StreamBuilder<bool>(
        stream: submitValid,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              // _verifyResult.sink
              //     .add(AWSVerifyModel(aws.CompareFacesResponse()));
              _bloc
                  .validateUser(imagePath1: image1Path)
                  .then((AWSVerifyModel model) {
                _verifyResult.sink.add(model);
                setState(() {});
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.white60, blurRadius: 6, spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blueGrey.withOpacity(0.65),
                        Colors.blueGrey
                      ])),
              child: const Center(
                  child: Text(
                'Validate User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600),
              )),
            ),
          );
        });
  }

  Widget getImageContainer(
      {Stream<FilePickerWrapperSuccessResult>? stream, int index = 0}) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.42,
      height: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(border: Border.all(color: Colors.white54)),
      child: StreamBuilder<FilePickerWrapperSuccessResult>(
          stream: stream,
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return Container(
                child: getImageContainerFromPath(snapshot.data?.filePath),
              );
            } else {
              return plusIcon(index);
            }
          }),
    );
  }

  Widget plusIcon(int index) {
    return Center(
      child: IconButton(
          onPressed: () {
            print('upload image');
            choosingImageForTile = index;
            _imagePickerWrapper?.openImagePicker(buildContext: context);
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white70,
          )),
    );
  }

  Widget getImageContainerFromPath(String? path) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.42,
          height: MediaQuery.of(context).size.width * 0.42,
          child: Image.file(
            File(path!),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _image1Status.close();
    _image2Status.close();
    _verifyResult.close();
    super.dispose();
  }
}
