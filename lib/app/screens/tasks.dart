import 'package:flutter/material.dart';

import '../../database/lista.dart';
import '../widgets/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int itemCount = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(42),

      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard.fromTask(task: taskList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
