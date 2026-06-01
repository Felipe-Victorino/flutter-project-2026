import 'package:flutter_project/app/model/category.dart';

class TaskTable {
  int? id;
  final String title;
  final String description;
  bool isCompleted = false;
  List<CategoryTable>? categories = List.empty(growable: true);
  String createTime = DateTime.now().toIso8601String();
  final String endTime;

  TaskTable({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.categories,
    required this.createTime,
    required this.endTime,
  });

  TaskTable.create(this.title, this.description, this.endTime, this.categories);

  factory TaskTable.fromMap(Map<String, Object?> map) {
    return TaskTable(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: (map['complete'] == 0 ? false : true),
      createTime: map['create_date'] as String,
      endTime: map['end_date'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'complete': isCompleted == false ? 0 : 1,
      'create_date': createTime,

      'end_date': endTime,
    };
  }

  String toString() {
    return '''
    Task(id:$id, 
    title:$title, 
    complete:$isCompleted, 
    create_date:$createTime, 
    end_date:$endTime
    
    )''';
  }

  void setCompleted() => isCompleted = isCompleted == false ? true : false;

  set changeStatus(bool value) => isCompleted = value;
}
