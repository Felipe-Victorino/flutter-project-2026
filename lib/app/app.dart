import 'package:flutter/material.dart';
import 'package:flutter_project/app/screens/create_task.dart';
import 'package:flutter_project/app/screens/screen_category_list.dart';
import 'package:flutter_project/app/screens/screen_completed_list.dart';

import 'screens/screen_home.dart';
import 'screens/screen_settings.dart';
import 'screens/screen_tasks_list.dart';
import 'widgets/tile_logo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    const TaskPage(),
    const CompletedPage(),
    const CategoryPage(),
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
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: Text("Categorias"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Text("Configurações"),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              label: Text("Add"),

              icon: Icon(Icons.add),
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
