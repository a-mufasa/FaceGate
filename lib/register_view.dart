import 'package:face_gate/scan_page_view.dart';
import 'package:flutter/material.dart';
import 'form_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Facegate'),
        ),
        body: const Center(
          child: RegisterButton(),
        ));
  }
}

class RegisterButton extends StatefulWidget {
  const RegisterButton({super.key});

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image(
        image: const AssetImage('assets/Logo.png'),
      ),
      Padding(padding: EdgeInsets.all(10)),
      ElevatedButton(
          onPressed: () {
            final newRoute =
                MaterialPageRoute(builder: (context) => const FormView());
            Navigator.push(context, newRoute);
          },
          child: const Text("Register")),
      TextButton(
          onPressed: () {
            final newRoute =
                MaterialPageRoute(builder: (context) => ScanPageView());
            Navigator.push(context, newRoute);
          },
          child: const Text("Existing user?"))
    ]);
  }
}
