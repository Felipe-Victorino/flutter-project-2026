import 'package:flutter/material.dart';
import 'package:flutter_project/app/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard.fromTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Divider(),
            Text(task.description.toString()),
            Text(task.createTime.toString()),
            Text(task.endTime.toString()),
            Text(task.isCompleted.toString()),
          ],
        ),
      ),
    );
  }
}
