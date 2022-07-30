part of 'notes_bloc.dart';

/// Abstract event dari [NotesBloc]
abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

/// Menambahkan note baru
class AddNote extends NotesEvent {
  const AddNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

/// Mengubah isi note
class EditNote extends NotesEvent {
  const EditNote({required this.oldNote, required this.newNote});
  final Note oldNote;
  final Note newNote;

  @override
  List<Object> get props => [oldNote, newNote];
}

/// Menyeleksi note
class SelectNote extends NotesEvent {
  const SelectNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

/// Membatalkan seleksi pada note
class UnselectNote extends NotesEvent {
  const UnselectNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

/// Menyeleksi semua note sekaligus
class SelectAllNotes extends NotesEvent {}

/// Membatalkan seleksi semua note yang diseleksi sekaligus
class UnselectAllNotes extends NotesEvent {}

/// Memindahkan note ke kotak sampah
class RemoveNote extends NotesEvent {
  const RemoveNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

/// Mengembalkan semua note yang diseleksi dari kotak sampah
class RestoreSelectedNotes extends NotesEvent {}

/// Menghapus semua note yang diseleksi
class DeleteSelectedNotes extends NotesEvent {}
