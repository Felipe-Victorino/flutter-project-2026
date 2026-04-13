import 'package:flutter/material.dart';

import '../../database/dao.dart';
import '../widgets/task.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<StatefulWidget> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final Dao dao = Dao();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(42),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: dao.getCompleted().isEmpty
                ? EmptyList()
                : ListView.builder(
                    itemCount: dao.getCompleted().length,
                    itemBuilder: (context, index) {
                      return TaskCard.fromTask(task: dao.getCompleted()[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
