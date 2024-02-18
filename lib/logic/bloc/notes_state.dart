part of 'notes_bloc.dart';

/// Data state yang di-manage oleh [NotesBloc], memiliki properti:
/// * [notes]
/// * [removedNotes]
/// * [selectedBinNotes]
class NotesState extends Equatable {
  NotesState({
    List<Note> notes = const <Note>[],
    List<Note> removedNotes = const <Note>[],
    this.selectedBinNotes = const <Note>[],
  })  :
        // Mengurutkan note berdasarkan tanggal terakhir diubah
        _notes = List.from(notes)
          ..sort(
            (note1, note2) {
              return note2.modifiedDate.compareTo(note1.modifiedDate);
            },
          ),
        // Mengurutkan removedNote berdasarkan tanggal terakhir diubah
        _removedNotes = List.from(removedNotes)
          ..sort(
            (removedNote1, removedNote2) {
              return removedNote2.modifiedDate
                  .compareTo(removedNote1.modifiedDate);
            },
          );

  final List<Note> _notes;

  /// List note utama
  List<Note> get notes => _notes;

  final List<Note> _removedNotes;

  /// List note yang berada di kotak sampah
  List<Note> get removedNotes => _removedNotes;

  /// Wadah List note yang digunakan untuk menyeleksi note
  final List<Note> selectedBinNotes;

  /// Import [NotesState] dari Json atau Map
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

  /// Export [NotesState] ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'notes': _notes.map((note) => note.toJson()).toList(),
      'removed_notes': _removedNotes.map((note) => note.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [_notes, _removedNotes, selectedBinNotes];
}
