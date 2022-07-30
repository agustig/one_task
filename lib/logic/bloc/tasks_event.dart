part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  const AddTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  const UpdateTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class EditTask extends TasksEvent {
  const EditTask({required this.oldTask, required this.newTask});

  final Task oldTask;
  final Task newTask;

  @override
  List<Object> get props => [oldTask, newTask];
}

class SelectTask extends TasksEvent {
  const SelectTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class UnselectTask extends TasksEvent {
  const UnselectTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class SelectAllTasks extends TasksEvent {}

class UnselectAllTasks extends TasksEvent {}

class RemoveTask extends TasksEvent {
  const RemoveTask({required this.task});

  final Task task;

  @override
  List<Object> get props => [task];
}

class RestoreSelectedTasks extends TasksEvent {}

class DeleteSelectedTasks extends TasksEvent {}
