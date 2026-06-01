import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../database/database_helper.dart';
import '../model/category.dart';
import 'dao.dart';

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
