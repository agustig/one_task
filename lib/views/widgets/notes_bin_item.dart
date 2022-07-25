import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../models/note.dart';

class NotesBinItem extends StatelessWidget {
  const NotesBinItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesBloc = context.watch<NotesBloc>();
    final removedNotes = notesBloc.state.removedNotes;
    final selectedNote = notesBloc.state.selectedNotes;

    void selectUnselectNote(Note note) {
      selectedNote.contains(note)
          ? notesBloc.add(UnselectNote(note: note))
          : notesBloc.add(SelectNote(note: note));
    }

    return ListView.builder(
      itemCount: removedNotes.length,
      itemBuilder: (context, index) {
        final note = removedNotes[index];
        return Card(
          child: ListTile(
            title: Text(removedNotes[index].title),
            subtitle: Text(note.noteBody),
            trailing: selectedNote.isNotEmpty
                ? Checkbox(
                    value: selectedNote.contains(note),
                    onChanged: (_) => selectUnselectNote(note),
                    activeColor: Colors.green,
                  )
                : null,
            selected: selectedNote.contains(note),
            onLongPress: selectedNote.isEmpty
                ? () => notesBloc.add(SelectNote(note: note))
                : null,
            selectedTileColor: Colors.black12,
            onTap:
                selectedNote.isNotEmpty ? () => selectUnselectNote(note) : null,
          ),
        );
      },
    );
  }
}