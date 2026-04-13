import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(42),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .stretch,

        children: [
          Text(
            "Configurações",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(padding: EdgeInsetsGeometry.all(12), child: Divider()),
          Card(
            child: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Column(
                children: [
                  Row(children: [Text("Modo Escuro:"), ThemeSwitch()]),
                ],
              ),
            ),
          ),
        ],
      ),
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
    return Switch(
      value: value,
      onChanged: (bool value) {
        setState(() {
          this.value = value;
        });
        App.of(context).changeTheme(value ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
