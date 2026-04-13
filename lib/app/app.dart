import 'package:flutter/material.dart';
import 'package:flutter_project/app/screens/completed.dart';
import 'package:flutter_project/app/screens/create_task.dart';

import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/tasks.dart';
import 'widgets/tile_logo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const TaskPage(),
    const CompletedPage(),
    const SettingsPage(),
  ];

  void handleScreenChange(int selectedScreen) {
    setState(() {
      _selectedIndex = selectedScreen;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        //foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('ToDoRe'),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: handleScreenChange,

        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: WordRow("ToDoRe"),
          ),
          Padding(padding: EdgeInsetsGeometry.all(12), child: Divider()),
          NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text("Tela Inicial"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: Text("Tarefas"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.archive_outlined),
            selectedIcon: Icon(Icons.archive),
            label: Text("Tarefas Completas"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Text("Configurações"),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex != 2
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const NewTaskPage(),
                  ),
                );
              },
            )
          : null,
    );
  }
}
