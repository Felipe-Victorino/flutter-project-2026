class Task {
  String title;
  String description;
  bool isCompleted = false;
  DateTime createTime = DateTime.now();
  DateTime endTime;

  Task.create(this.title, this.description, this.endTime);

  void setCompleted() => isCompleted = isCompleted == false ? true : false;
}
