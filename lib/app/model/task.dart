class Task {
  final int id = DateTime.now().millisecondsSinceEpoch;
  String title;
  String description;
  bool isCompleted = false;
  DateTime createTime = DateTime.now();
  DateTime endTime;

  Task.create(this.title, this.description, this.endTime);

  void setCompleted() => isCompleted = isCompleted == false ? true : false;

  set changeStatus(bool value) => isCompleted = value;
}
