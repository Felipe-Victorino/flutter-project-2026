import 'package:flutter/material.dart';
import 'package:flutter_project/app/widgets/task.dart';

import '../model/task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(42),
      child: Column(
        crossAxisAlignment: .stretch,
        mainAxisAlignment: .start,
        children: [
          Padding(padding: EdgeInsetsGeometry.all(12), child: Divider()),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TaskCard.fromTask(
                    task: Task.create(
                      "Tarefa 1",
                      "Primeira Tarefa",
                      DateTime.now(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
