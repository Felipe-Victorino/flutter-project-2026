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
  final TaskService service = TaskService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getTaskCloserToExpire(),
      builder: (context, AsyncSnapshot<TaskTable?> snapshot) {
        return Padding(
          padding: EdgeInsetsGeometry.all(42),
          child: Column(
            spacing: 12,
            crossAxisAlignment: .stretch,
            mainAxisAlignment: .start,
            children: [
              Text("Tarefas próximas"),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(12),
                  child: snapshot.data == null
                      ? EmptyList()
                      : TaskCard.fromTask(
                          task: snapshot.data!,
                          callback: () => {},
                        ),
                ),
              ),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const NewTaskPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
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
      },
    );
  }
}
