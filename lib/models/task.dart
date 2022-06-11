class Task {
  Task({
    required this.title,
    required this.detail,
    required this.place,
    required this.startTime,
    required this.endTime,
  });

  String title;
  String detail;
  String place;
  DateTime startTime;
  DateTime endTime;
}

class TaskManager {
  TaskManager(this.task, {
    this.isWaiting = true,
    this.isDone = false,
  });

  Task task;
  bool isWaiting;
  bool isDone;
}