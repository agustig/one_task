import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logic/logic.dart';
import '../../models/note.dart';
import '../views.dart';

/// Widget yang menampilakan note dalam bentuk kartu
class NoteGrid extends StatelessWidget {
  const NoteGrid({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              // Ketika note ditekan(onTap), muncul halaman popup
              // NoteForm untuk mengedit note.
              onTap: () {
                showFormModalBottom(context, NoteFormScreen(note: note));
              },

              // Ketika note dipendam(onLongPress), akan muncul peringatan
              // hapus note yang bersangkutan.
              onLongPress: () {
                showDeleteDialog(
                    context: context,
                    type: DeleteType.remove,
                    onSubmit: () {
                      context.read<NotesBloc>().add(RemoveNote(note: note));
                    });
              },
              child: Card(
                color: note.background,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(note.noteBody),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                showNoteTime(note.modifiedDate),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Menampilkan informasi waktu berdasarkan jarak waktu parameter
  /// [DateTime] dengan waktu sekarang (DateTime.now())
  Text showNoteTime(DateTime noteDate) {
    final now = DateTime.now();
    const style = TextStyle(color: Colors.black54, fontSize: 13);
    if (now.year == noteDate.year) {
      if (now.month == noteDate.month && now.day == noteDate.day) {
        return Text(
          DateFormat('hh:mm a').format(noteDate),
          style: style,
        );
      } else {
        return Text(
          DateFormat.MMMMd('id_ID').format(noteDate),
          style: style,
        );
      }
    } else {
      return Text(
        DateFormat.yMMMMd('id_ID').format(noteDate),
        style: style,
      );
    }
  }
}
