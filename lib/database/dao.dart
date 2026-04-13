import '../app/model/task.dart';
import './lista.dart';

class Dao {
  void addTask(Task task) {
    taskList.add(task);
  }

  Task? getTask(int id) {
    Task? found;

    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].id == id) {
        found = taskList[i];
        break;
      }
    }
    return found;
  }

  List<Task> getAll() {
    return taskList;
  }

  List<Task> getCompleted() {
    return taskList.where((task) => task.isCompleted == true).toList();
  }

  List<Task> getIncompleted() {
    return taskList.where((task) => task.isCompleted != true).toList();
  }

  Task? getEarliestDeadline() {
    List<Task> tasks = getIncompleted();
    if (tasks.isEmpty) {
      return null;
    } else {
      Task earliest = tasks[0];
      for (int i = 0; i < taskList.length; i++) {
        if (tasks[i].endTime.isBefore(earliest.endTime)) {
          earliest = tasks[i];
        }
      }
      return earliest;
    }
  }

  void updateTask(Task task) {
    for (int i = 0; i < taskList.length; i++) {
      if (taskList[i].id == task.id) {
        taskList[i] = task;
        break;
      }
    }
  }

  void removeTask(Task task) {
    taskList.remove(task);
  }
}
