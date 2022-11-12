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
        body: const Align(
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
        image: const AssetImage('assets/temp_logo.png'),
        width: 120,
        height: 75,
      ),
      Padding(padding: EdgeInsets.all(10)),
      TextButton(
          onPressed: () {
            final newRoute =
                MaterialPageRoute(builder: (context) => const FormView());
            Navigator.push(context, newRoute);
          },
          child: const Text("Register"))
    ]);
  }
}
