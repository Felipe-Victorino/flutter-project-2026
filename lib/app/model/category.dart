import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCloud {
  String? id;
  final String? name;
  final String? color;

  CategoryCloud({this.id, required this.name, required this.color});

  factory CategoryCloud.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CategoryCloud(
      id: snapshot.id,
      name: data?['name'],
      color: data?['color'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {if (name != null) 'name': name, if (color != null) 'color': color};
  }
}

class CategoryTable {
  int? id;
  final String name;

  CategoryTable({this.id, required this.name});

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name};
  }

  factory CategoryTable.fromMap(Map<String, Object?> map) {
    return CategoryTable(id: map['id'] as int, name: map['name'] as String);
  }

  CategoryTable fromMap(Map<String, Object?> map) {
    return CategoryTable(id: map['id'] as int, name: map['name'] as String);
  }

  String toString() {
    return "Category(id:$id, name:$name)";
  }
}
