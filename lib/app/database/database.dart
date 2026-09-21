import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    DatabaseFactory factory = databaseFactoryFfi;

    if (kIsWeb) {
      factory = databaseFactoryFfiWeb;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final String dbPath = path.join(appDir.path, 'todore');
    await Directory(dbPath).create(recursive: true);

    Database db = await factory.openDatabase(
      path.join(dbPath, 'todore.db'),
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
      ),
    );
    print("Database created and started");

    return db;
  }

  Future _onConfigure(Database db) async {
    db.execute('PRAGMA foreign_keys = ON;');
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE IF NOT EXISTS categories(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
        );
    
    
      CREATE TABLE IF NOT EXISTS tasks(
         id INTEGER PRIMARY KEY,
         title TEXT NOT NULL,
         description TEXT NOT NULL,
         complete INTEGER NOT NULL,
         create_date TEXT NOT NULL,
         end_date TEXT NOT NULL
      );
     
    
      CREATE TABLE IF NOT EXISTS taskcategories(
         task_id INTEGER,
         category_id INTEGER,
         PRIMARY KEY(task_id, category_id),
         FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
         FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
      );
    ''');
  }
}
