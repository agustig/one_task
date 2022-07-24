import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../widgets/widgets.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesBloc = context.watch<NotesBloc>();
    final removedNotes = notesBloc.state.removedNotes;
    final selectedNote = notesBloc.state.selectedNotes;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: selectedNote.isNotEmpty
              ? IconButton(
                  onPressed: () => notesBloc.add(UnselectAllNotes()),
                  icon: const Icon(Icons.arrow_back_sharp),
                )
              : null,
          title: Text(
            selectedNote.isEmpty
                ? 'Kotak Sampah'
                : '${selectedNote.length}/${removedNotes.length} selected',
          ),
          actions: selectedNote.isNotEmpty
              ? [
                  IconButton(
                    onPressed: () => notesBloc.add(RestoreSelectedNotes()),
                    icon: const Icon(
                      Icons.restore_page_outlined,
                    ),
                    tooltip: 'Restore',
                  ),
                  IconButton(
                    onPressed: () => notesBloc.add(DeleteSelectedNotes()),
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                    tooltip: 'Hapus Permanent',
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => notesBloc.add(SelectAllNotes()),
                        child: const Text('Pilih Semua'),
                      ),
                    ],
                  )
                ]
              : null,
          bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.bodyText1,
              labelColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Task',
                ),
                Tab(
                  text: 'Catatan',
                )
              ]),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const NotesBinItem(),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const NotesBinItem(),
            ),
          ],
        ),
      ),
    );
  }
}
