import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> allTasks = List.from(state.allTasks)..add(event.task);
    allTasks.sort((task1, task2) => task1.startTime.compareTo(task2.startTime));

    emit(TasksState(allTasks: allTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final task = event.task;
    var allTasks = state.allTasks;
    final taskIndex = allTasks.indexOf(task);

    if (!task.isDone) {
      allTasks = List.from(allTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: true));
    } else {
      allTasks = List.from(allTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: false));
    }

    emit(TasksState(allTasks: allTasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toJson();
  }
}
