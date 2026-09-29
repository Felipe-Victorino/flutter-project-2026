import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/app/dao/task_category.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database/database.dart';
import '../model/task.dart';
import 'dao.dart';

class TaskDaoCloud {
  DocumentReference _getDocById(String id) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("tasks")
        .doc(id)
        .withConverter<TaskCloud>(
          fromFirestore: TaskCloud.fromFirestore,
          toFirestore: (TaskCloud task, _) => task.toFirestore(),
        );
  }

  Future<String> insert(TaskCloud task) async {
    final db = FirebaseFirestore.instance;
    String id = await db
        .collection("tasks")
        .add(task.toFirestore())
        .then((documentSnapshot) => documentSnapshot.id);
    return id;
  }

  Future<TaskCloud?> getById(String id) async {
    final DocumentReference docref = _getDocById(id);

    final snapshot = await docref.get();
    return snapshot.data() as TaskCloud?;
  }

  Future<List<TaskCloud?>> getAll() async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("tasks")
        .get();
    final List<TaskCloud?> result = snapshot.docs.map((doc) {
      return TaskCloud.fromFirestore(doc, null);
    }).toList();

    return result;
  }

  Future<List<TaskCloud?>> getAllOrderBy(String field) async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("tasks")
        .orderBy(field)
        .get();

    final List<TaskCloud?> result = snapshot.docs.map((doc) {
      return TaskCloud.fromFirestore(doc, null);
    }).toList();

    return result;
  }

  Future<String> update(TaskCloud task) async {
    final DocumentReference docref = _getDocById(task.id!);

    docref.update(task.toFirestore());

    return docref.id;
  }

  Future<String> remove(String id) async {
    final DocumentReference docref = _getDocById(id);

    docref.delete();

    return docref.id;
  }

  Future<void> addCategoryToTask(String id, String idCat) async {
    final DocumentReference docref = _getDocById(id);
    docref.update({
      'categories': FieldValue.arrayUnion([idCat]),
    });
  }

  Future<void> removeCategoryFromTask(String id, String idCat) async {
    final DocumentReference docref = _getDocById(id);
    docref.update({
      'categories': FieldValue.arrayRemove([idCat]),
    });
  }
}

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

      List<TaskTable> returnList = List.empty(growable: true);

      for (Map<String, Object?> map in listTable) {
        returnList.add(TaskTable.fromMap(map));
        print(map.values);
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
