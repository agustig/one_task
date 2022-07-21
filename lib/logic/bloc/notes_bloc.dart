import 'package:equatable/equatable.dart';

import '../../models/note.dart';
import '../logic.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<RemoveNote>(_onRemoveNote);
  }

  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    emit(NotesState(notes: List.from(state.notes)..add(event.note)));
  }

  void _onEditNote(EditNote event, Emitter<NotesState> emit) {
    final oldNote = event.oldNote;
    final newNote = event.newNote;
    var notes = state.notes;
    final noteIndex = notes.indexOf(oldNote);
    notes = List.from(notes)
      ..remove(oldNote)
      ..insert(
        noteIndex,
        oldNote.copyWith(newNote.title, newNote.noteBody),
      );

    emit(NotesState(notes: notes));
  }

  void _onRemoveNote(RemoveNote event, Emitter<NotesState> emit) {
    emit(NotesState(notes: List.from(state.notes)..remove(event.note)));
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }
}
