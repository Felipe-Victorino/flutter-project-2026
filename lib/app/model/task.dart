class Task {
  final int id = DateTime.now().millisecondsSinceEpoch;
  String title;
  String description;
  bool isCompleted = false;
  DateTime createTime = DateTime.now();
  DateTime endTime;

  Task.create(this.title, this.description, this.endTime);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'complete': isCompleted,
      'create_date': createTime,
      'end_date': endTime,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Task(id:$id, title:$title, complete:$isCompleted, create_date:$createTime, end_date:$endTime)';
  }

  void setCompleted() => isCompleted = isCompleted == false ? true : false;

  set changeStatus(bool value) => isCompleted = value;
}
