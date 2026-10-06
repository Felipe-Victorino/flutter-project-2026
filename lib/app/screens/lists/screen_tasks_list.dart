import 'package:flutter/material.dart';
import 'package:flutter_project/app/service/task_service.dart';

import '../../model/task.dart';
import '../../widgets/container/page_container.dart';
import '../../widgets/task.dart';
import '../create/create_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskCloud?>? _tasklist;
  final TaskServiceCloud service = TaskServiceCloud();

  void _refreshList() async {
    List<TaskCloud?> result = await service.getIncompleteTasks();
    setState(() {
      _tasklist = result as List<TaskCloud?>?;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute<void>(
                builder: (context) => const NewTaskPage(),
              ),
            );
            _refreshList();
          },

          child: Text("Criar Tarefa nova"),
        ),

        Expanded(
          child: _tasklist == null || _tasklist!.isEmpty
              ? EmptyList()
              : ListView.builder(
                  itemCount: _tasklist!.length,
                  itemBuilder: (context, index) {
                    return TaskCard.fromTask(
                      task: _tasklist![index]!,
                      callback: _refreshList,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
