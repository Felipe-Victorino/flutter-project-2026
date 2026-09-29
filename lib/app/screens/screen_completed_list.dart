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
  List<TaskCloud?>? _tasklist;
  final TaskServiceCloud service = TaskServiceCloud();

  void _refreshList() async {
    List<TaskCloud?> result = await service.getIncompleteTasks();
    setState(() {
      _tasklist = result as List<TaskCloud?>?;
    });
    print("refresh");
  }

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(28),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
      ),
    );
  }
}
