import 'package:flutter/material.dart';
import 'package:flutter_project/app/model/task.dart';
import 'package:flutter_project/app/service/task_service.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Text("No tasks...."),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task, required this.callback});

  const TaskCard.fromTask({
    super.key,
    required this.task,
    required this.callback,
  });

  final TaskTable task;
  final Function callback;

  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  double _isComplete = 1;
  String _taskButtonLabel = "Completar";
  IconData _taskButtonIcon = Icons.check_circle;
  TaskService service = TaskService();

  @override
  void initState() {
    super.initState();

    service.setTaskCategories(widget.task);

    if (widget.task.isCompleted == true) {
      _isComplete = 0;
      _taskButtonIcon = Icons.restore;
      _taskButtonLabel = "Restaurar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: .saturation(_isComplete),
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Divider(),
              Text(widget.task.description),
              Text("Date of creation: ${widget.task.createTime})"),
              Text("Date of end: ${widget.task.endTime}"),
              Wrap(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: widget.task.categories?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ActionChip.elevated(
                          label: Text(
                            widget.task.categories![index].name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight(900),
                            ),
                          ),
                          onPressed: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),

              /*FutureBuilder(
                future: category,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ActionChip.elevated(
                          label: Text(snapshot.data!.name),
                          onPressed: () {},
                        )
                      : ActionChip.elevated(label: const Text("No category"));
                },
              ),*/
              Wrap(
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 8,
                runSpacing: 4,

                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Removing a task"),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    'You are deleting this task permanently,',
                                  ),
                                  Text(
                                    'Are you sure you want to remove this task?',
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    print("Removing");
                                    service.deleteTask(widget.task);
                                    widget.callback();
                                  });

                                  Navigator.pop(context);
                                },
                                child: const Text("Yes, delete task"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.callback();
                                },
                                child: const Text("No, do not delete it"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    label: Text("Remover"),
                    icon: Icon(Icons.remove_circle),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.task.isCompleted =
                            widget.task.isCompleted == true ? false : true;
                        if (widget.task.isCompleted == true) {
                          _isComplete = 0;
                          _taskButtonIcon = Icons.restore;
                          _taskButtonLabel = "Restaurar";
                        } else {
                          _isComplete = 1;
                          _taskButtonIcon = Icons.check_circle;
                          _taskButtonLabel = "Completar";
                        }
                        service.updateTask(widget.task);
                      });
                    },
                    icon: Icon(_taskButtonIcon),
                    label: Text(_taskButtonLabel),
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
