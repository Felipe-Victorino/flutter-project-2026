import 'package:flutter/material.dart';
import 'package:flutter_project/app/model/task.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Text("No tasks...."),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});

  const TaskCard.fromTask({super.key, required this.task});

  final Task task;

  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  double _isComplete = 1;
  String _taskButtonLabel = "Completar";
  IconData _taskButtonIcon = Icons.check_circle;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: .saturation(_isComplete),
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Divider(),
              Text(widget.task.description.toString()),
              Text(widget.task.createTime.toString()),
              Text(widget.task.endTime.toString()),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.task.isCompleted = true;
                      print("Change");
                      setState(() {
                        _isComplete = _isComplete == 1 ? 0 : 1;
                        _taskButtonIcon = _taskButtonIcon == Icons.check_circle
                            ? Icons.restore
                            : Icons.check_circle;
                        _taskButtonLabel = _taskButtonLabel == "Completar"
                            ? "Restaurar"
                            : "Completar";
                      });
                    },
                    child: Row(
                      children: [Icon(_taskButtonIcon), Text(_taskButtonLabel)],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
