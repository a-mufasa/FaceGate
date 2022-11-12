import 'package:flutter/material.dart';
import 'dart:developer';
import 'new_lock_scan_view.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Facegate'),
        ),
        body: const Center(
          child: RegistrationForm(),
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
  noErrors
}

class _RegistrationFormState extends State<RegistrationForm> {
  var firstName = "";
  var lastName = "";
  var password = "";
  var verifyPassword = "";
  var validForm = false;
  var errorLabel = "";

  Errors validateInputs(String firstName, String lastName, String password,
      String passwordVerification) {
    if (firstName == '') return Errors.nullFirstName;
    if (lastName == '') return Errors.nullLastName;
    if (password == '') return Errors.nullPassword;
    if (password == '') return Errors.nullVerifyPassword;
    if (password != passwordVerification) return Errors.passwordDoNotMatch;

    return Errors.noErrors;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
            onChanged: ((value) async {
              firstName = value;
            }),
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "First Name")),
        TextField(
            onChanged: ((value) async {
              lastName = value;
            }),
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Last Name")),
        TextField(
            onChanged: ((value) async {
              password = value;
            }),
            style: TextStyle(fontSize: 15),
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password")),
        TextField(
            onChanged: ((value) async {
              verifyPassword = value;
            }),
            style: TextStyle(fontSize: 15),
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Re-enter Password")),
        TextButton(
            onPressed: () async {
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

              if (errorMessage == Errors.noErrors) {
                //apicall to store info to db,

                //thenReroute

                final newRoute =
                    MaterialPageRoute(builder: (context) => const FormView());
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
