import 'package:flutter/material.dart';

import '../widgets/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int itemCount = 3;
  List<TaskCard> taskList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Tarefas", style: Theme.of(context).textTheme.headlineLarge),
          Padding(padding: EdgeInsetsGeometry.all(12), child: Divider()),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Theme.of(context).cardColor,
                  minTileHeight: 50,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
