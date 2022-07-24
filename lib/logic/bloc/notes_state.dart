part of 'notes_bloc.dart';

class NotesState extends Equatable {
  NotesState({
    List<Note> notes = const <Note>[],
    List<Note> removedNotes = const <Note>[],
    this.selectedNotes = const <Note>[],
  })  : _notes = List.from(notes)
          ..sort(
            (note1, note2) {
              return note2.modifiedDate.compareTo(note1.modifiedDate);
            },
          ),
        _removedNotes = List.from(removedNotes)
          ..sort(
            (removedNote1, removedNote2) {
              return removedNote2.modifiedDate
                  .compareTo(removedNote1.modifiedDate);
            },
          );

  final List<Note> _notes;
  List<Note> get notes => _notes;

  final List<Note> _removedNotes;
  List<Note> get removedNotes => _removedNotes;

  final List<Note> selectedNotes;

  factory NotesState.fromJson(Map<String, dynamic> json) {
    return NotesState(
      notes: List.from(
        json['notes']?.map(
          (note) => Note.fromJson(note),
        ),
      ),
      removedNotes: List.from(
        json['removed_notes']?.map(
          (note) => Note.fromJson(note),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': _notes.map((note) => note.toJson()).toList(),
      'removed_notes': _removedNotes.map((note) => note.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [_notes, _removedNotes, selectedNotes];
}
