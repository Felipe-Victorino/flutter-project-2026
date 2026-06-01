import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();

  static _AppState of(BuildContext context) =>
      context.findRootAncestorStateOfType<_AppState>()!;
}

class _AppState extends State<App> {
  ThemeMode _theme = ThemeMode.light;

  void changeTheme(ThemeMode theme) {
    setState(() {
      _theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('pt-BR'),
      title: 'Test App',
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _theme,

      home: const Home(),
    );
  }
}

const Color seedColor = Colors.indigo;
final ThemeData darkTheme = ThemeData(
  brightness: .dark,
  useMaterial3: true,
  colorScheme: .fromSeed(seedColor: seedColor, brightness: .dark),
);

final ThemeData lightTheme = ThemeData(
  brightness: .light,
  useMaterial3: true,
  colorScheme: .fromSeed(seedColor: seedColor, brightness: .light),
);
