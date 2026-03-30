import 'package:flutter_project/app/model/task.dart';

class TaskList {
  List<Task> taskList = List.empty(growable: true);

  TaskList();

  void add(Task task) {
    taskList.add(task);
  }

  Task? get(DateTime createTime) {
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].createTime == createTime) {
        return taskList[i];
      }
    }
    return null;
  }
}
