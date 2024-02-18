import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

/// BLoC untuk me-manage [Note]
class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<SelectBinNote>(_onSelectBinNote);
    on<UnselectBinNote>(_onUnselectBinNote);
    on<SelectAllBinNotes>(_onSelectAllBinNotes);
    on<UnselectAllBinNotes>(_onUnselectAllBinNotes);
    on<RemoveNote>(_onRemoveNote);
    on<RestoreSelectedBinNotes>(_onRestoreSelectedBinNotes);
    on<DeleteSelectedBinNotes>(_onDeleteSelectedBinNotes);
  }

  /// Memproses event [AddNote]
  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: List.from(state.notes)..add(event.note),
        removedNotes: state.removedNotes,
      ),
    );
  }

  /// Memproses event [EditNote]
  void _onEditNote(EditNote event, Emitter<NotesState> emit) {
    final oldNote = event.oldNote;
    final newNote = event.newNote;
    var notes = state.notes;
    var removedNotes = state.removedNotes;

    // Mengedit note yang berada dalam List State notes
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

    emit(NotesState(notes: notes, removedNotes: removedNotes));
  }

  /// Memproses event [SelectBinNote]
  void _onSelectBinNote(SelectBinNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
        selectedBinNotes: List.from(state.selectedBinNotes)..add(event.note),
      ),
    );
  }

  /// Memposes event [UnselectBinNote]
  void _onUnselectBinNote(UnselectBinNote event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
        selectedBinNotes: List.from(state.selectedBinNotes)..remove(event.note),
      ),
    );
  }

  /// Memproses event [SelectAllBinNotes]
  void _onSelectAllBinNotes(SelectAllBinNotes event, Emitter<NotesState> emit) {
    final notes = state.notes;
    final removedNotes = state.removedNotes;
    final selectedNotes = List<Note>.from(removedNotes);

    emit(
      NotesState(
        notes: notes,
        removedNotes: removedNotes,
        selectedBinNotes: selectedNotes,
      ),
    );
  }

  /// Memproses event [UnselectAllBinNotes]
  void _onUnselectAllBinNotes(
      UnselectAllBinNotes event, Emitter<NotesState> emit) {
    emit(
      NotesState(
        notes: state.notes,
        removedNotes: state.removedNotes,
      ),
    );
  }

  /// Memproses event [RemoveNote]
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

  /// Memproses event [RestoreSelectedBinNotes]
  void _onRestoreSelectedBinNotes(
    RestoreSelectedBinNotes event,
    Emitter<NotesState> emit,
  ) {
    final notes = state.notes;
    final removedNotes = state.removedNotes;
    final selectedNotes = state.selectedBinNotes;

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

  /// Memproses event [DeleteSelectedNote]
  void _onDeleteSelectedBinNotes(
    DeleteSelectedBinNotes event,
    Emitter<NotesState> emit,
  ) {
    final removedNotes = state.removedNotes;
    final selectedNotes = state.selectedBinNotes;

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

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }
}
