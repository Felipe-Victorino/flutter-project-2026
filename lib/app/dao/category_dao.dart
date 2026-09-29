import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database/database.dart';
import '../model/category.dart';
import 'dao.dart';

class CategoryDaoCloud {
  Future<String> insert(CategoryCloud task) async {
    final db = FirebaseFirestore.instance;
    String id = await db
        .collection("categories")
        .add(task.toFirestore())
        .then((documentSnapshot) => documentSnapshot.id);
    return id;
  }

  Future<CategoryCloud?> getById(String id) async {
    final db = FirebaseFirestore.instance;
    final DocumentReference docref = db
        .collection("categories")
        .doc(id)
        .withConverter<CategoryCloud>(
          fromFirestore: CategoryCloud.fromFirestore,
          toFirestore: (CategoryCloud task, _) => task.toFirestore(),
        );

    final snapshot = await docref.get();
    return snapshot.data() as CategoryCloud?;
  }

  Future<List<CategoryCloud?>> getAll() async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("categories")
        .get();
    final List<CategoryCloud?> result = snapshot.docs.map((doc) {
      return CategoryCloud.fromFirestore(doc, null);
    }).toList();

    return result;
  }

  Future<String> update(CategoryCloud category) async {
    final db = FirebaseFirestore.instance;
    final DocumentReference docref = db
        .collection("categories")
        .doc(category.id)
        .withConverter<CategoryCloud>(
          fromFirestore: CategoryCloud.fromFirestore,
          toFirestore: (CategoryCloud category, _) => category.toFirestore(),
        );

    docref.update(category.toFirestore());

    return docref.id;
  }

  Future<String> remove(String id) async {
    final db = FirebaseFirestore.instance;
    final DocumentReference docref = db
        .collection("categories")
        .doc(id)
        .withConverter<CategoryCloud>(
          fromFirestore: CategoryCloud.fromFirestore,
          toFirestore: (CategoryCloud task, _) => task.toFirestore(),
        );

    docref.delete();

    return docref.id;
  }
}

class CategoryDao extends Dao<CategoryTable> {
  @override
  Future<int> insert(CategoryTable category) async {
    final Database? db = await DatabaseHelper.instance.database;
    int genid = await db!.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return genid;
  }

  @override
  Future<List<CategoryTable>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    try {
      final List<Map<String, Object?>> listTable = await db!.query(
        'categories',
      );

      return [
        for (final {'id': id as int, 'name': name as String} in listTable)
          CategoryTable(id: id, name: name),
      ];
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<CategoryTable?> getById(int id) async {
    final List<CategoryTable> tasklist = await getAll();
    CategoryTable? found;
    for (CategoryTable t in tasklist) {
      if (t.id == id) {
        found = t;
      }
    }
    return found;
  }

  @override
  Future<void> update(CategoryTable t) async {
    final db = await DatabaseHelper.instance.database;
    db!.update('categories', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
  }

  @override
  Future<void> remove(int id) async {
    final db = await DatabaseHelper.instance.database;
    db!.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
