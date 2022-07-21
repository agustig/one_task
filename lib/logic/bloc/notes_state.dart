part of 'notes_bloc.dart';

class NotesState extends Equatable {
  NotesState({List<Note> notes = const <Note>[]})
      : notes = List.from(notes)
          ..sort(
            (note1, note2) {
              return note2.modifiedDate.compareTo(note1.modifiedDate);
            },
          );

  final List<Note> notes;

  factory NotesState.fromJson(Map<String, dynamic> json) {
    return NotesState(
      notes: List.from(json['notes']?.map((note) => Note.fromJson(note))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes.map((note) => note.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [notes];
}
