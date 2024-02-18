part of 'tasks_bloc.dart';

/// Data state yang di-manage oleh [TasksBloc], memiliki properti:
/// * [allTasks]
/// * [todayTasks]
/// * [removedTasks]
/// * [selectedBinTasks]
class TasksState extends Equatable {
  TasksState({
    List<Task> allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.selectedBinTasks = const <Task>[],
  }) :
        // Mengurutkan task berdasarkan waktu mulai
        _allTasks = List.from(allTasks)
          ..sort(
            (task1, task2) => task1.startTime.compareTo(task2.startTime),
          ) {
    // Mengambil data task yang terjadi hari ini di allTasks lalu
    // memasukkan kedalam variabel todayTasks
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

  /// List task utama
  List<Task> get allTasks => _allTasks;

  /// List task utama yang terjadi hari ini
  late final List<Task> todayTasks;

  /// List task yang berada di kotak sampah
  final List<Task> removedTasks;

  /// Wadah List task yang digunakan untuk menyeleksi task
  final List<Task> selectedBinTasks;

  /// Import [TasksState] dari Json atau Map
  factory TasksState.fromJson(Map<String, dynamic> json) {
    return TasksState(
      allTasks: List.from(
        json['all_task']?.map((task) => Task.fromJson(task)),
      ),
      removedTasks: List.from(
        json['removed_tasks']?.map((task) => Task.fromJson(task)),
      ),
    );
  }

  /// Export [TasksState] ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'all_task': _allTasks.map((task) => task.toJson()).toList(),
      'removed_tasks': removedTasks.map((task) => task.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [
        _allTasks,
        todayTasks,
        removedTasks,
        selectedBinTasks,
      ];
}
