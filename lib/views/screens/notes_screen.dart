import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../views.dart';

/// Halaman untuk menampilkan semua note / catatan.
class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return SliverGrid(
            delegate: SliverChildListDelegate.fixed(
              state.notes.map((note) {
                return NoteGrid(note: note);
              }).toList(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
          );
        },
      ),
    );
  }
}
