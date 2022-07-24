import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            note != null ? 'Edit catatan' : 'Tambah catatan',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          BuildTextField(
            controller: titleController,
            label: 'Judul',
            hint: 'Kontak pengacara',
          ),
          BuildTextField(
            controller: noteBodyController,
            label: 'Isi catatan',
            hint: '+62 852-428-43234',
            minLines: 3,
            maxLines: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Periksa apakah edit note atau tambah note baru
                  // dan memberi judul defaul apabila zero value
                  final noteTitle = (titleController.text != '')
                      ? titleController.text
                      : 'Catatan ${DateFormat('MM/dd').format(
                          (note != null) ? note!.createDate : DateTime.now(),
                        )}';
                  final newNote = Note(
                    title: noteTitle,
                    noteBody: noteBodyController.text,
                  );
                  if (note != null) {
                    context.read<NotesBloc>().add(EditNote(
                          oldNote: note!,
                          newNote: newNote,
                        ));
                  } else {
                    context.read<NotesBloc>().add(AddNote(note: newNote));
                  }
                  Navigator.pop(context);
                },
                child: Text(note != null ? 'Edit' : 'Tambah'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
