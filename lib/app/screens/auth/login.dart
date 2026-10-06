import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/screens/auth/signin.dart';
import 'package:flutter_project/app/widgets/tile_logo.dart';

import '../../app.dart';
import '../../widgets/container/auth_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageFormState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(
        child: Column(
          spacing: 24,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            WordRow("ToDoRe"),

            Center(child: Column(children: [_LoginPageForm()])),
          ],
        ),
      ),
    );
  }
}

class _LoginPageFormState extends State<_LoginPageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailctrl = TextEditingController();
  final TextEditingController _passwdctrl = TextEditingController();

  String? _email;
  String? _passwd;

  void _message(String msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToSignin() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => SigninPage()));
  }

  void _navigateToHome() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => Home()));
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email!,
        password: _passwd!,
      );

      _navigateToHome();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        _message("Usuário ou senha não encontrados");
      } else if (e.code == 'wrong-password') {
        _message("Usuário ou senha não encontrados");
      } else if (e.code == 'too-many-requests') {
        _message("Muitas requisições, tente novamente");
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
          ElevatedButton.icon(
            onPressed: _navigateToSignin,
            label: Text("Criar conta"),
          ),
        ],
      ),
    );
  }
}
