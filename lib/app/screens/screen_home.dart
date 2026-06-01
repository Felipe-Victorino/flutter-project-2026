import 'package:flutter/material.dart';
import 'package:flutter_project/app/screens/create_category.dart';
import 'package:flutter_project/app/service/task_service.dart';
import 'package:flutter_project/app/widgets/task.dart';

import '../model/task.dart';
import 'create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<TaskTable?>? urgentTask;
  final TaskService service = TaskService();

  void _refreshList() {
    setState(() {
      urgentTask = service.getTaskCloserToExpire();
    });
  }

  @override
  void initState() {
    super.initState();
    print("Starting home");
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        crossAxisAlignment: .stretch,
        mainAxisAlignment: .start,
        children: [
          Text("Tarefas próximas"),
          FutureBuilder(
            future: urgentTask,
            builder: (context, snapshot) {
              return Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(12),
                  child: snapshot.data == null
                      ? EmptyList()
                      : TaskCard.fromTask(
                          task: snapshot.data!,
                          callback: _refreshList,
                        ),
                ),
              );
            },
          ),

          Row(
            spacing: 8,

            mainAxisAlignment: .spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const NewTaskPage(),
                    ),
                  );
                },

                child: Text("Criar Tarefa nova"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const CreateCategoryPage(),
                    ),
                  );
                },
                child: Text("Criar Categoria nova"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
