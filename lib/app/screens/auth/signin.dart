import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/widgets/container/auth_card.dart';

import '../../widgets/tile_logo.dart';

class SigninPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SigninPageState();
}

class _SigninPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SigninPageFormState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(
        child: Column(
          spacing: 24,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            WordRow("Todore"),
            Center(child: Column(children: [_SigninPageForm()])),
          ],
        ),
      ),
    );
  }
}

class _SigninPageFormState extends State<_SigninPageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailctrl = TextEditingController();
  final TextEditingController _passwdctrl = TextEditingController();

  String? _email;
  String? _passwd;

  void _message(String msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState?.save();

    if (_email == null) {
      _message("Null email");
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email!, password: _passwd!);

      _navigateBack();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _message('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _message('The account already exists for that email.');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailctrl.dispose();
    _passwdctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,

      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        spacing: 8,
        children: <Widget>[
          TextFormField(
            controller: _emailctrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
            onSaved: (String? s) {
              setState(() {
                _email = _emailctrl.text;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Preencha o seu email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwdctrl,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Senha',
            ),
            onSaved: (String? s) {
              setState(() {
                _passwd = _passwdctrl.text;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Preencha a sua senha';
              }
              return null;
            },
          ),
          ElevatedButton.icon(onPressed: _login, label: Text("Entrar")),
        ],
      ),
    );
  }
}
