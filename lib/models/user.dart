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
    List<Note>? notes,
  }) : _tasks = tasks {
    // Menambahkan notes ke dalam _notes apabila
    // notes tidak kosong
    if (notes != null) {
      _notes.addAll(notes);
    }
  }

  /// Class dari pengguna
  final User user;

  // Semua task di satu pengguna
  final List<Task> _tasks;

  // Semua note di satu pengguna
  final _notes = <Note>[];

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

  /// Menambah task baru ke dalam list
  addTask(Task task) {
    _tasks.add(task);
  }

  /// Menambah note baru ke dalam list
  addNote(Note note) {
    _notes.add(note);
  }

  /// Menghapus note dari list
  deleteNote(int index) {
    _notes.removeAt(index);
  }

  /// Mengambil semua task dalam bentuk list
  List<Task> get allTasks => _tasks;

  /// Mengambil semua note dalam bentuk list
  List<Note> get allNotes => _notes;
}
