import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<EditTask>(_onEditTask);
    on<SelectTask>(_onSelectTask);
    on<UnselectTask>(_onUnselectTask);
    on<SelectAllTasks>(_onSelectAllTasks);
    on<UnselectAllTasks>(_onUnselectAllTasks);
    on<RemoveTask>(_onRemoveTask);
    on<RestoreSelectedTasks>(_onRestoreSelectedTasks);
    on<DeleteSelectedTasks>(_onDeleteSelectedTasks);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> allTasks = List.from(state.allTasks)..add(event.task);

    emit(TasksState(allTasks: allTasks, removedTasks: state.removedTasks));
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

    emit(TasksState(allTasks: allTasks, removedTasks: state.allTasks));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final oldTask = event.oldTask;
    final newTask = event.newTask;
    final taskIndex = state.allTasks.indexOf(oldTask);

    emit(
      TasksState(
        allTasks: List.from(state.allTasks)
          ..remove(oldTask)
          ..insert(taskIndex, newTask),
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onSelectTask(SelectTask event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        allTasks: state.allTasks,
        removedTasks: state.removedTasks,
        selectedTasks: List.from(state.selectedTasks)..add(event.task),
      ),
    );
  }

  void _onUnselectTask(UnselectTask event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        allTasks: state.allTasks,
        removedTasks: state.removedTasks,
        selectedTasks: List.from(state.selectedTasks)..remove(event.task),
      ),
    );
  }

  void _onSelectAllTasks(SelectAllTasks event, Emitter<TasksState> emit) {
    final allTasks = state.allTasks;
    final removedTasks = state.removedTasks;
    var selectedTasks = state.selectedTasks;

    if (selectedTasks[0].isRemoved) {
      selectedTasks = removedTasks;
    } else {
      selectedTasks = allTasks;
    }

    emit(TasksState(
      allTasks: allTasks,
      removedTasks: removedTasks,
      selectedTasks: selectedTasks,
    ));
  }

  void _onUnselectAllTasks(UnselectAllTasks event, Emitter<TasksState> emit) {
    emit(TasksState(
      allTasks: state.allTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final task = event.task;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(task),
        removedTasks: List.from(state.removedTasks)
          ..insert(0, task.copyWith(isRemoved: true)),
      ),
    );
  }

  void _onRestoreSelectedTasks(
    RestoreSelectedTasks event,
    Emitter<TasksState> emit,
  ) {
    var allTasks = state.allTasks;
    var removedTasks = state.removedTasks;
    final seletedTasks = state.selectedTasks;

    for (var task in seletedTasks) {
      allTasks = List.from(allTasks)..add(task.copyWith(isRemoved: false));
      removedTasks = List.from(removedTasks)..remove(task);
    }

    emit(TasksState(
      allTasks: allTasks,
      removedTasks: removedTasks,
    ));
  }

  void _onDeleteSelectedTasks(
      DeleteSelectedTasks event, Emitter<TasksState> emit) {
    final allTasks = state.allTasks;
    var removedTasks = state.removedTasks;
    final selectedTasks = state.selectedTasks;

    for (var task in selectedTasks) {
      removedTasks = List.from(removedTasks)..remove(task);
    }

    emit(TasksState(allTasks: allTasks, removedTasks: removedTasks));
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
