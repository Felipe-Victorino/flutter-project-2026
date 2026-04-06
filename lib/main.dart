import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  static const Color seedColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: .light,

        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: seedColor, brightness: .light),
      ),
      darkTheme: ThemeData(
        brightness: .dark,
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: seedColor, brightness: .dark),
      ),
      themeMode: ThemeMode.system,

      home: const Home(),
    );
  }
}
