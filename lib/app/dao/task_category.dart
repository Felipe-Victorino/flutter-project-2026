import 'package:flutter_project/app/model/category.dart';
import 'package:flutter_project/app/model/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database/database_helper.dart';

class TaskCategoryDao {
  TaskCategoryDao();

  Future<List<CategoryTable>> getCategoriesForTask(TaskTable task) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, Object?>> maps = await db!.rawQuery(
      '''
    SELECT c.* 
    FROM categories c
    INNER JOIN taskcategories tc ON c.id = tc.category_id
    WHERE tc.task_id = ?
    ''',
      [task.id],
    );

    return List.generate(
      maps.length,
      (index) => CategoryTable.fromMap(maps[index]),
    );
  }

  Future<List<TaskTable>> getTasksForCategory(CategoryTable category) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, Object?>> maps = await db!.rawQuery(
      '''
    SELECT t.*
    FROM tasks t
    INNER JOIN taskcategories tc ON t.id = tc.task_id
    WHERE tc.category_id = ?
        ''',
      [category.id],
    );

    return List.generate(
      maps.length,
      (index) => TaskTable.fromMap(maps[index]),
    );
  }

  Future<void> linkCategoryToTask(int taskId, CategoryTable category) async {
    final db = await DatabaseHelper.instance.database;

    db!.insert('taskcategories', {
      'task_id': taskId,
      'category_id': category.id,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> unlinkCategoryFromTask(
    TaskTable task,
    CategoryTable category,
  ) async {
    final db = await DatabaseHelper.instance.database;
    db!.delete(
      'taskcategories',
      where: 'task_id = ? AND category_id = ?',
      whereArgs: [task.id, category.id],
    );
  }
}
