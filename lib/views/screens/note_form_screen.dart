import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../models/note.dart';
import '../widgets/widgets.dart';

/// Halaman untuk manambahkan atau mengedit Note.
///
/// Untuk mengedit note masukkan parameter [note],
class NoteFormScreen extends StatelessWidget {
  const NoteFormScreen({
    Key? key,
    this.note,
  }) : super(key: key);
  final Note? note;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final noteBodyController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      noteBodyController.text = note!.noteBody;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(
          note != null ? 'Edit catatan' : 'Tambah catatan',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                // Periksa apakah edit note atau tambah note baru
                final newNote = Note(
                  title: titleController.text,
                  noteBody: noteBodyController.text,
                );
                if (note != null) {
                  context.read<NotesBloc>().add(EditNote(
                        oldNote: note!,
                        newNote: newNote,
                      ));
                } else {
                  // notes.add(newNote);
                  context.read<NotesBloc>().add(AddNote(note: newNote));
                }
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              BuildTextField(
                controller: titleController,
                label: 'Judul',
                hint: 'Kontak pengacara',
              ),
              BuildTextField(
                controller: noteBodyController,
                label: 'Isi catatan',
                hint: '+62 852-428-43234',
                maxLines: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
