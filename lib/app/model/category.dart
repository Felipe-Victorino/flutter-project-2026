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
