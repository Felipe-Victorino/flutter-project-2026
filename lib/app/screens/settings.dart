import 'package:flutter/material.dart';

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
              child: Column(children: []),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPalette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Text("Primary"),
            Card.filled(color: Theme.of(context).primaryColor),
          ],
        ),
        Column(children: [Text("Secondary")]),
        Column(children: [Text("Tertiary")]),
      ],
    );
  }
}
