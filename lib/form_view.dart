import 'package:flutter/material.dart';
import 'dart:developer';

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
            onPressed: () {
              var errorMessage =  validateInputs(firstName, lastName, password, verifyPassword);
              if errorMessage = 
              // final newRoute =
              //     MaterialPageRoute(builder: (context) => const FormView());
              // Navigator.push(context, newRoute);
            },
            child: const Text("Register Account")),
        Text(errorLabel),
      ],
    );
  }
}
