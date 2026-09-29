import 'package:flutter_project/app/dao/task_category.dart';
import 'package:flutter_project/app/model/task.dart';

import '../dao/task_dao.dart';
import '../model/category.dart';

class TaskServiceCloud {
  final TaskDaoCloud _dao = TaskDaoCloud();

  Future<String> addCategoryToTask(String taskid, CategoryCloud cate) async {
    TaskCloud? task = await getById(taskid);
    task?.categories?.add(cate);

    return updateTask(task!);
  }

  Future<TaskCloud?> getClosestToExpire() async {
    List<TaskCloud?> task = await _dao.getAllOrderBy("end_time");
    return task.first;
  }

  Future<List<TaskCloud?>> getIncompleteTasks() async {
    List<TaskCloud?> result = await _dao.getAll();
    List<TaskCloud?> incompleteList = List.empty(growable: true);

    for (TaskCloud? t in result) {
      if (t?.isCompleted == false) {
        incompleteList.add(t);
      }
    }
    ;

    return incompleteList;
  }

  Future<List<TaskCloud?>> getCompleteTasks() async {
    List<TaskCloud?> result = await _dao.getAll();
    List<TaskCloud?> completeList = List.empty(growable: true);

    for (TaskCloud? t in result) {
      if (t?.isCompleted == true) {
        completeList.add(t);
      }
    }
    ;

    return completeList;
  }

  Future<TaskCloud?> getById(String id) async {
    return await _dao.getById(id);
  }

  Future<String> createNewTask(TaskCloud task) async {
    return await _dao.insert(task);
  }

  Future<String> updateTask(TaskCloud task) async {
    return await _dao.update(task);
  }

  Future<String> deleteTask(String? id) async {
    return await _dao.remove(id!);
  }
}

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
