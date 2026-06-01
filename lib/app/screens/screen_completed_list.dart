import 'package:flutter/material.dart';

import '../model/task.dart';
import '../service/task_service.dart';
import '../widgets/task.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<StatefulWidget> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  Future<List<TaskTable>?>? _tasklist;
  final TaskService service = TaskService();

  void refreshList() {
    setState(() {
      _tasklist = service.getCompleteTasks();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
        children: <Widget>[
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
