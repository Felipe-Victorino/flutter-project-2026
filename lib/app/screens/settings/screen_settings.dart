import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';

import '../../widgets/container/page_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      children: [
        Text("Configurações", style: Theme.of(context).textTheme.headlineLarge),
        Padding(padding: EdgeInsetsGeometry.all(12), child: Divider()),
        Card(
          child: Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .stretch,
              spacing: 24,
              children: [
                ThemeSwitch(),
                ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  label: Text("Sair"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      title: Text("Modo Escuro:"),
      onChanged: (bool value) {
        setState(() {
          this.value = value;
        });
        App.of(context).changeTheme(value ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
