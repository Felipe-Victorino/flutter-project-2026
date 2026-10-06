import 'package:flutter/material.dart';
import 'package:flutter_project/app/screens/create/create_category.dart';
import 'package:flutter_project/app/service/task_service.dart';
import 'package:flutter_project/app/widgets/container/page_container.dart';
import 'package:flutter_project/app/widgets/task.dart';

import '../model/task.dart';
import 'create/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<TaskCloud?>? urgentTask;
  final TaskServiceCloud service = TaskServiceCloud();

  void _refreshList() {
    setState(() {
      urgentTask = service.getClosestToExpire();
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

        Wrap(
          spacing: 8,
          runSpacing: 8,
          runAlignment: .spaceEvenly,
          crossAxisAlignment: .center,
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
    );
  }
}
