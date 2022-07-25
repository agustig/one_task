part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  TasksState({
    List<Task> allTasks = const <Task>[],
  }) : _allTasks = List.from(allTasks)
          ..sort(
            (task1, task2) => task1.startTime.compareTo(task2.startTime),
          ) {
    final timeNow = DateTime.now();
    todayTasks = _allTasks.where(
      (task) {
        return (task.startTime.isBefore(timeNow) &&
                task.endTime.isAfter(timeNow)) ||
            (task.startTime.year == timeNow.year &&
                task.startTime.month == timeNow.month &&
                task.startTime.day == timeNow.day);
      },
    ).toList();
  }

  final List<Task> _allTasks;
  List<Task> get allTasks => _allTasks;
  late final List<Task> todayTasks;

  @override
  List<Object> get props => [_allTasks, todayTasks];

  factory TasksState.fromJson(Map<String, dynamic> json) {
    return TasksState(
      allTasks: List.from(json['all_task']?.map((task) => Task.fromJson(task))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all_task': _allTasks.map((task) => task.toJson()).toList(),
    };
  }
}
