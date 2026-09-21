import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/task_service.dart';

import '../model/task.dart';
import '../widgets/task.dart';
import 'create_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<List<TaskTable>?>? _tasklist;
  final TaskService service = TaskService();

  void refreshList() {
    setState(() {
      _tasklist = service.getIncompleteTasks();
    });
  }

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(28),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute<void>(
                  builder: (context) => const NewTaskPage(),
                ),
              );
              refreshList();
            },

            child: Text("Criar Tarefa nova"),
          ),
          FutureBuilder(
            future: _tasklist,
            builder: (context, snapshot) {
              return Expanded(
                child: snapshot.data == null
                    ? EmptyList()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TaskCard.fromTask(
                            task: snapshot.data![index],
                            callback: refreshList,
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
