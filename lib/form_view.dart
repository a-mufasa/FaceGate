import 'dart:typed_data';
import 'package:face_gate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'scan_page_view.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Facegate'),
        ),
        body: const Center(
          child: SingleChildScrollView(child: RegistrationForm()),
        ));
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

enum Errors {
  nullFirstName,
  nullLastName,
  nullPassword,
  nullVerifyPassword,
  passwordDoNotMatch,
  nullPhoto,
  noErrors
}

class _RegistrationFormState extends State<RegistrationForm> {
  var firstName = "";
  var lastName = "";
  var password = "";
  var verifyPassword = "";
  var validForm = false;
  bool pictureChosen = false;
  var errorLabel = "";
  Uint8List? image;

  Errors validateInputs(String firstName, String lastName, String password,
      String passwordVerification) {
    if (firstName == '') return Errors.nullFirstName;
    if (lastName == '') return Errors.nullLastName;
    if (password == '') return Errors.nullPassword;
    if (password == '') return Errors.nullVerifyPassword;
    // if (image == null) return Errors.nullPhoto;
    if (password != passwordVerification) return Errors.passwordDoNotMatch;

    return Errors.noErrors;
  }

  Future<String> selectImage() async {
    Uint8List _image = await pickImage(ImageSource.gallery);
    setState(() {
      image = _image;
      pictureChosen = true;
    });
    return "";
  }

  Future<String> takeImage() async {
    Uint8List _image = await pickImage(ImageSource.camera);
    setState(() {
      image = _image;
      getSetImage.setImage(image!);
      pictureChosen = true;
    });
    return "";
  }

  Widget _displayImage(Uint8List? bytes) {
    if (bytes == null) {
      return Image.asset(
        'assets/no_image.jpg',
        width: 120,
        height: 70,
      );
    }

    return Image.memory(bytes, width: 1000, height: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _displayImage(image),
        Divider(
          height: 20,
          thickness: 5,
          endIndent: 0,
          color: Colors.black,
        ),
        ElevatedButton(
            onPressed: () {
              takeImage();
            },
            child: const Text("Take a Picture")),
        ElevatedButton(
            onPressed: () {
              selectImage();
            },
            child: const Text("Choose a Picture")),
        SizedBox(
          width: 350,
          child: TextField(
              onChanged: ((value) async {
                firstName = value;
              }),
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "First Name")),
        ),
        SizedBox(
            width: 350,
            child: TextField(
                onChanged: ((value) async {
                  lastName = value;
                }),
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Last Name"))),
        SizedBox(
          width: 350,
          child: TextField(
              onChanged: ((value) async {
                password = value;
              }),
              style: TextStyle(fontSize: 15),
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password")),
        ),
        SizedBox(
          width: 350,
          child: TextField(
              onChanged: ((value) async {
                verifyPassword = value;
              }),
              style: TextStyle(fontSize: 15),
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Re-enter Password")),
        ),
        TextButton(
            onPressed: () async {
              // await selectImage();
              var errorMessage =
                  validateInputs(firstName, lastName, password, verifyPassword);

              if (errorMessage == Errors.nullFirstName) {
                errorLabel = 'Please fill out the first name field!';
              }
              if (errorMessage == Errors.nullLastName) {
                errorLabel = 'Please fill out the last name field!';
              }
              if (errorMessage == Errors.nullPassword) {
                errorLabel = 'Please fill out the password field!';
              }
              if (errorMessage == Errors.nullVerifyPassword) {
                errorLabel = 'Please fill out the password verification field!';
              }

              if (errorMessage == Errors.passwordDoNotMatch) {
                errorLabel = 'Please ensure that your passwords match!';
              }

              if (errorMessage == Errors.nullPhoto) {
                errorLabel = 'Please ensure that you have selected a photo!';
              }

              if (errorMessage == Errors.noErrors) {
                //apicall to store info to db,

                //thenReroute

                final newRoute = MaterialPageRoute(
                    builder: (context) => ScanPageView(
                          firstName: firstName,
                          lastName: lastName,
                          password: password,
                          dbImage: image,
                        ));
                Navigator.push(context, newRoute);
              } else {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: Text('$errorLabel'),
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
            },
            child: const Text("Register Account")),
        Text(errorLabel),
      ],
    );
  }
}
