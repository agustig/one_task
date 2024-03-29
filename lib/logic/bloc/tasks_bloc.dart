import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

/// BLoC untuk me-manage [Task]
class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<EditTask>(_onEditTask);
    on<SelectBinTask>(_onSelectBinTask);
    on<UnselectBinTask>(_onUnselectBinTask);
    on<SelectAllBinTasks>(_onSelectAllBinTasks);
    on<UnselectAllBinTasks>(_onUnselectAllBinTasks);
    on<RemoveTask>(_onRemoveTask);
    on<RestoreSelectedBinTasks>(_onRestoreSelectedBinTasks);
    on<DeleteSelectedBinTasks>(_onDeleteSelectedBinTasks);
  }

  /// Memproses event [AddTask]: Menambahkan task baru
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> allTasks = List.from(state.allTasks)..add(event.task);

    emit(TasksState(allTasks: allTasks, removedTasks: state.removedTasks));
  }

  /// Memproses event [UpdateTask]
  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final task = event.task;
    var allTasks = state.allTasks;
    final taskIndex = allTasks.indexOf(task);

    // Mengecek apakah task sudah selesai atau done
    if (!task.isDone) {
      allTasks = List.from(allTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: true));
    } else {
      allTasks = List.from(allTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: false));
    }

    emit(TasksState(allTasks: allTasks, removedTasks: state.removedTasks));
  }

  /// Memproses event [EditTask]
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

  /// Memproses event [SelectBinTask]
  void _onSelectBinTask(SelectBinTask event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        allTasks: state.allTasks,
        removedTasks: state.removedTasks,
        selectedBinTasks: List.from(state.selectedBinTasks)..add(event.task),
      ),
    );
  }

  /// Memproses event [UnselectBinTask]
  void _onUnselectBinTask(UnselectBinTask event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        allTasks: state.allTasks,
        removedTasks: state.removedTasks,
        selectedBinTasks: List.from(state.selectedBinTasks)..remove(event.task),
      ),
    );
  }

  /// Memproses event [SelectAllBinTasks]
  void _onSelectAllBinTasks(SelectAllBinTasks event, Emitter<TasksState> emit) {
    final allTasks = state.allTasks;
    final removedTasks = state.removedTasks;
    var selectedTasks = List<Task>.from(removedTasks);

    emit(TasksState(
      allTasks: allTasks,
      removedTasks: removedTasks,
      selectedBinTasks: selectedTasks,
    ));
  }

  /// Memproses event [UnselectAllBinTasks]
  void _onUnselectAllBinTasks(
      UnselectAllBinTasks event, Emitter<TasksState> emit) {
    emit(TasksState(
      allTasks: state.allTasks,
      removedTasks: state.removedTasks,
    ));
  }

  /// Memproses event [RemoveTask]
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

  /// Memproses event [RestoreSelectedBinTasks]
  void _onRestoreSelectedBinTasks(
    RestoreSelectedBinTasks event,
    Emitter<TasksState> emit,
  ) {
    var allTasks = state.allTasks;
    var removedTasks = state.removedTasks;
    final seletedTasks = state.selectedBinTasks;

    for (var task in seletedTasks) {
      allTasks = List.from(allTasks)..add(task.copyWith(isRemoved: false));
      removedTasks = List.from(removedTasks)..remove(task);
    }

    emit(TasksState(
      allTasks: allTasks,
      removedTasks: removedTasks,
    ));
  }

  /// Memproses event [DeleteSelectedBinTasks]
  void _onDeleteSelectedBinTasks(
      DeleteSelectedBinTasks event, Emitter<TasksState> emit) {
    final allTasks = state.allTasks;
    var removedTasks = state.removedTasks;
    final selectedTasks = state.selectedBinTasks;

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
