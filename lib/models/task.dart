/// Class yang berisikan rincian task
class Task {
  Task({
    required this.title,
    required this.detail,
    required this.place,
    required this.startTime,
    required this.endTime,
  });

  /// Judul dari task
  String title;

  /// Isi dari task
  String detail;

  /// Tempat dimana taks dikerjakan
  String place;

  /// Batas waktu awal task dikerjakan
  DateTime startTime;

  /// Batas waktu task berakhir
  DateTime endTime;
}

/// Pengatur task
class TaskManager {
  TaskManager(this.task, {
    this.isWaiting = true,
    this.isDone = false,
  });

  /// [Task] rincian task
  Task task;

  /// Informasi apakah task masih belum dikerjakan
  bool isWaiting;

  /// Informasi apakah task sudah dikejakan
  bool isDone;
}