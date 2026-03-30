import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  static const Color seedColor = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: seedColor),
      ),

      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
