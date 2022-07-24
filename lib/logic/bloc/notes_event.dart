part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends NotesEvent {
  const AddNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class EditNote extends NotesEvent {
  const EditNote({required this.oldNote, required this.newNote});
  final Note oldNote;
  final Note newNote;

  @override
  List<Object> get props => [oldNote, newNote];
}

class SelectNote extends NotesEvent {
  const SelectNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class UnselectNote extends NotesEvent {
  const UnselectNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class SelectAllNotes extends NotesEvent {}

class UnselectAllNotes extends NotesEvent {}

class RemoveNote extends NotesEvent {
  const RemoveNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class RestoreNote extends NotesEvent {
  const RestoreNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class RestoreSelectedNotes extends NotesEvent {}

class DeleteNote extends NotesEvent {
  const DeleteNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}

class DeleteSelectedNotes extends NotesEvent {}
