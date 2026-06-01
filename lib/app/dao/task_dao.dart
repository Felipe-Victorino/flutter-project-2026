import 'package:flutter_project/app/dao/task_category.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database/database_helper.dart';
import '../model/task.dart';
import 'dao.dart';

class TaskDao extends Dao<TaskTable> {
  @override
  Future<int> insert(TaskTable task) async {
    final Database? db = await DatabaseHelper.instance.database;
    int genId = await db!.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return genId;
  }

  @override
  Future<TaskTable?> getById(int id) async {
    final List<TaskTable> tasklist = await getAll();
    TaskTable? found;
    for (TaskTable t in tasklist) {
      if (t.id == id) {
        found = t;
      }
    }
    return found;
  }

  @override
  Future<List<TaskTable>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    TaskCategoryDao tc = TaskCategoryDao();
    try {
      final List<Map<String, Object?>> listTable = await db!.query('tasks');
      final List<TaskTable> returnList = List.empty(growable: true);
      for (Map<String, Object?> map in listTable) {
        returnList.add(TaskTable.fromMap(map));
      }
      for (TaskTable t in returnList) {
        t.categories = await tc.getCategoriesForTask(t);
      }
      return returnList;
    } on Exception catch (_) {
      return [];
    }
  }

  Future<List<TaskTable>?> getAllDate() async {
    final db = await DatabaseHelper.instance.database;
    TaskCategoryDao tc = TaskCategoryDao();
    try {
      final String query = "SELECT * FROM tasks ORDER BY end_date DESC";
      final List<Map<String, Object?>> listTable = await db!.rawQuery(query);

      final List<TaskTable> returnList = List.empty(growable: true);
      for (Map<String, Object?> map in listTable) {
        returnList.add(TaskTable.fromMap(map));
      }
      for (TaskTable t in returnList) {
        t.categories = await tc.getCategoriesForTask(t);
      }

      return returnList;
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<void> update(TaskTable t) async {
    final db = await DatabaseHelper.instance.database;

    db!.update('tasks', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
  }

  @override
  Future<void> remove(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db!.delete('tasks', where: 'id= ?', whereArgs: [id]);
  }
}
