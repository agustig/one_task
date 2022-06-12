import 'package:intl/intl.dart';
import 'package:one_task/models/models.dart';

/// Class yang berisikan informasi pengguna
class User {
  User({required this.name, required this.image});

  /// Nama pengguna
  String name;

  /// Photo profile pengguna
  String image;
}

/// Pengatur task pengguna
class UserTasksManager {
  UserTasksManager({
    required this.user,
    required List<Task> tasks,
  }) : _tasks = tasks;

  /// Class dari pengguna
  final User user;

  // Semua task di satu pengguna
  final List<Task> _tasks;

  /// List task yang hari ini
  List<Task> get todayTask {
    final tasksToday = <Task>[];
    for (var task in _tasks) {
      final startDate = DateFormat('yyyy-MM-dd').format(task.startTime);
      final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (startDate == todayDate) {
        tasksToday.add(task);
      }
    }
    return tasksToday;
  }

  /// Menambah task baru
  addTask(Task task) {
    _tasks.add(task);
  }

  /// Mengambil semua task dalam bentuk list
  List<Task> get allTask => _tasks;
}
