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

class RemoveNote extends NotesEvent {
  const RemoveNote({required this.note});
  final Note note;

  @override
  List<Object> get props => [note];
}
