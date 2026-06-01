import 'package:flutter_project/app/dao/task_category.dart';
import 'package:flutter_project/app/model/task.dart';

import '../dao/task_dao.dart';
import '../model/category.dart';

class TaskService {
  final TaskDao _dao = TaskDao();

  Future<CategoryTable?> associateTaskWithCategory(
    TaskTable task,
    CategoryTable category,
  ) async {
    if (task.categories != null && task.id != null) {
      TaskCategoryDao tcdao = TaskCategoryDao();
      tcdao.linkCategoryToTask(task.id!, category);
      task.categories!.add(category);
    }
    return null;
  }

  Future<void> setTaskCategories(TaskTable task) async {
    TaskCategoryDao tcdao = TaskCategoryDao();
    task.categories = await tcdao.getCategoriesForTask(task);
  }

  Future<List<TaskTable>?> getIncompleteTasks() async {
    List<TaskTable>? tasklist = await _dao.getAll();
    List<TaskTable>? incompleteTasks = List.empty(growable: true);
    for (TaskTable t in tasklist) {
      if (t.isCompleted == false) {
        incompleteTasks.add(t);
      }
    }
    return incompleteTasks;
  }

  Future<List<TaskTable>?> getCompleteTasks() async {
    List<TaskTable>? tasklist = await _dao.getAll();
    List<TaskTable>? completeTasks = List.empty(growable: true);
    for (TaskTable t in tasklist) {
      if (t.isCompleted == true) {
        completeTasks.add(t);
      }
    }
    return completeTasks;
  }

  Future<TaskTable?> getTaskCloserToExpire() async {
    List<TaskTable>? tasklist = await _dao.getAllDate();
    TaskTable? task = tasklist!.first;
    print("found");
    return task;
  }

  Future<int> createNewTask(TaskTable task) async {
    return _dao.insert(task);
  }

  void updateTask(TaskTable t) async {
    _dao.update(t);
  }

  void deleteTask(TaskTable t) async {
    if (t.id != null) {
      _dao.remove(t.id!);
    }
    return;
  }
}
