import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../widgets/widgets.dart';

/// Tampilan layar untuk kotak sampah
class BinScreen extends StatelessWidget {
  const BinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil bloc dari note
    final notesBloc = context.watch<NotesBloc>();
    final removedNotes = notesBloc.state.removedNotes;
    final selectedNote = notesBloc.state.selectedBinNotes;

    // Mengambil bloc dari task
    final tasksBloc = context.watch<TasksBloc>();
    final removedTasks = tasksBloc.state.removedTasks;
    final selectedTasks = tasksBloc.state.selectedBinTasks;

    // Leading AppBar yang terkondisi ketika ada item yang diseleksi
    Widget? appBarLeading() {
      if (selectedNote.isNotEmpty || selectedTasks.isNotEmpty) {
        return IconButton(
          onPressed: () => selectedNote.isNotEmpty
              ? notesBloc.add(UnselectAllBinNotes())
              : tasksBloc.add(UnselectAllBinTasks()),
          icon: const Icon(Icons.arrow_back_sharp),
        );
      } else {
        return null;
      }
    }

    // Title AppBar yang terkondisi ketika ada item yang diseleksi
    Widget appBarTitle() {
      final titleString = selectedNote.isNotEmpty
          ? '${selectedNote.length}/${removedNotes.length} selected'
          : selectedTasks.isNotEmpty
              ? '${selectedTasks.length}/${removedTasks.length} selected'
              : 'Kotak Sampah';
      return Text(titleString);
    }

    // Action AppBar yang terkondisi ketika ada item yang diseleksi
    List<Widget>? appBarActions() {
      if (selectedNote.isNotEmpty || selectedTasks.isNotEmpty) {
        return [
          IconButton(
            onPressed: () => selectedNote.isNotEmpty
                ? notesBloc.add(RestoreSelectedBinNotes())
                : tasksBloc.add(RestoreSelectedBinTasks()),
            icon: const Icon(
              Icons.restore_page_outlined,
            ),
            tooltip: 'Restore',
          ),
          IconButton(
            onPressed: () => showDeleteDialog(
              context: context,
              type: DeleteType.delete,
              onSubmit: () => selectedNote.isNotEmpty
                  ? notesBloc.add(DeleteSelectedBinNotes())
                  : tasksBloc.add(DeleteSelectedBinTasks()),
            ),
            icon: const Icon(
              Icons.delete_forever,
            ),
            tooltip: 'Hapus Permanent',
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => selectedNote.isNotEmpty
                    ? notesBloc.add(SelectAllBinNotes())
                    : tasksBloc.add(SelectAllBinTasks()),
                child: const Text('Pilih Semua'),
              ),
            ],
          )
        ];
      } else {
        return null;
      }
    }

    // List tab yang akan digunakan untuk keperluan TabBar
    List<Tab> tabs = const [
      Tab(
        text: 'Task',
      ),
      Tab(
        text: 'Catatan',
      )
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context);

        // Mendeteksi perubahan halaman tab
        tabController.addListener(
          () {
            if (tabController.indexIsChanging ||
                tabController.animation!.value == tabController.index) {
              notesBloc.add(UnselectAllBinNotes());
              tasksBloc.add(UnselectAllBinTasks());
            }
          },
        );

        return Scaffold(
          appBar: AppBar(
            leading: appBarLeading(),
            title: appBarTitle(),
            actions: appBarActions(),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              labelColor: Colors.black,
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: const TasksBinItem()),
              Container(
                padding: const EdgeInsets.all(20),
                child: const NotesBinItem(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
