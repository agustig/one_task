import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<SelectNote>(_onSelectNote);
    on<UnselectNote>(_onUnselectNote);
    on<SelectAllNotes>(_onSelectAllNotes);
    on<UnselectAllNotes>(_onUnselectAllNotes);
    on<RemoveNote>(_onRemoveNote);
    on<RestoreSelectedNotes>(_onRestoreSelectedNotes);
    on<DeleteNote>(_onDeleteNote);
    on<DeleteSelectedNotes>(_onDeleteSelectedNotes);
  }

  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
          notes: List.from(state.notes)..add(event.note),
          removedNotes: state.removedNotes),
    );
  }

  void _onEditNote(EditNote event, Emitter<NotesState> emit) {
    final oldNote = event.oldNote;
    final newNote = event.newNote;
    var notes = state.notes;
    var removedNotes = state.removedNotes;
    if (oldNote.isRemoved) {
      final noteIndex = removedNotes.indexOf(oldNote);
      removedNotes = List.from(removedNotes)
        ..remove(oldNote)
        ..insert(
          noteIndex,
          newNote.copyWith(
            id: oldNote.id,
            isRemoved: oldNote.isRemoved,
            createDate: oldNote.createDate,
            background: oldNote.background,
          ),
        );
    } else {
      final noteIndex = notes.indexOf(oldNote);
      notes = List.from(notes)
        ..remove(oldNote)
        ..insert(
          noteIndex,
          newNote.copyWith(
            createDate: oldNote.createDate,
            background: oldNote.background,
          ),
        );
    }

    emit(NotesState(notes: notes, removedNotes: removedNotes));
  }

  void _onSelectNote(SelectNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
        selectedNotes: List.from(state.selectedNotes)..add(event.note),
      ),
    );
  }

  void _onUnselectNote(UnselectNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
        selectedNotes: List.from(state.selectedNotes)..remove(event.note),
      ),
    );
  }

  void _onSelectAllNotes(SelectAllNotes event, Emitter<NotesState> emit) {
    final notes = state.notes;
    final removedNotes = state.removedNotes;
    var selectedNotes = state.selectedNotes;

    if (selectedNotes[0].isRemoved) {
      selectedNotes = List.from(removedNotes);
    } else {
      selectedNotes = List.from(notes);
    }

    emit(
      NotesState(
        notes: notes,
        removedNotes: removedNotes,
        selectedNotes: selectedNotes,
      ),
    );
  }

  void _onUnselectAllNotes(UnselectAllNotes event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
      ),
    );
  }

  void _onRemoveNote(RemoveNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: List.from(state.notes)..remove(event.note),
        removedNotes: List.from(state.removedNotes)
          ..insert(
            0,
            event.note.copyWith(
              isRemoved: true,
            ),
          ),
      ),
    );
  }

  void _onRestoreSelectedNotes(
    RestoreSelectedNotes event,
    Emitter<NotesState> emit,
  ) {
    final notes = state.notes;
    final removedNotes = state.removedNotes;
    final selectedNotes = state.selectedNotes;

    for (var note in selectedNotes) {
      removedNotes.remove(note);
      notes.add(note.copyWith(isRemoved: false));
    }

    emit(
      NotesState(
        notes: List.from(notes),
        removedNotes: List.from(removedNotes),
      ),
    );
  }

  void _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: List.from(state.removedNotes)..remove(event.note),
      ),
    );
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }

  void _onDeleteSelectedNotes(
    DeleteSelectedNotes event,
    Emitter<NotesState> emit,
  ) {
    final removedNotes = state.removedNotes;
    final selectedNotes = state.selectedNotes;

    for (var note in selectedNotes) {
      removedNotes.remove(note);
    }

    emit(
      NotesState(
        notes: List.from(state.notes),
        removedNotes: List.from(removedNotes),
      ),
    );
  }
}
