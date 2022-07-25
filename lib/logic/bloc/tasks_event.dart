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
