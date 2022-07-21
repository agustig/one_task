part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  TasksState({
    this.allTasks = const <Task>[],
  }) {
    final timeNow = DateTime.now();
    todayTasks = allTasks
        .where((task) =>
            task.startTime.year == timeNow.year &&
            task.startTime.month == timeNow.month &&
            task.startTime.day == timeNow.day)
        .toList();
  }

  final List<Task> allTasks;
  late final List<Task> todayTasks;

  @override
  List<Object> get props => [allTasks, todayTasks];

  factory TasksState.fromJson(Map<String, dynamic> json) {
    return TasksState(
      allTasks: List.from(json['all_task']?.map((task) => Task.fromJson(task))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all_task': allTasks.map((task) => task.toJson()).toList(),
    };
  }
}
