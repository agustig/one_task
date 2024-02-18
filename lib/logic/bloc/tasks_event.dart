part of 'tasks_bloc.dart';

/// Abstract event dari [TasksBloc]
abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

/// Menambahkan task baru
class AddTask extends TasksEvent {
  const AddTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

/// Mengupdate task
class UpdateTask extends TasksEvent {
  const UpdateTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

/// Mengubah isi task
class EditTask extends TasksEvent {
  const EditTask({required this.oldTask, required this.newTask});

  final Task oldTask;
  final Task newTask;

  @override
  List<Object> get props => [oldTask, newTask];
}

/// Meyeleksi task
class SelectBinTask extends TasksEvent {
  const SelectBinTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

/// Membatalkan seleksi pada task
class UnselectBinTask extends TasksEvent {
  const UnselectBinTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

/// Menyeleksi semua task sekaligus
class SelectAllBinTasks extends TasksEvent {}

/// Membatalkan seleksi semua task yang diseleksi sekaligus
class UnselectAllBinTasks extends TasksEvent {}

/// Memindahkan task ke kotak sampah
class RemoveTask extends TasksEvent {
  const RemoveTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

/// Mengembalkan semua task yang diseleksi dari kotak sampah
class RestoreSelectedBinTasks extends TasksEvent {}

/// Menghapus semua task yang diseleksi
class DeleteSelectedBinTasks extends TasksEvent {}
