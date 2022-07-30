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

    final tasksBloc = context.watch<TasksBloc>();
    final removedTasks = tasksBloc.state.removedTasks;
    final selectedTasks = tasksBloc.state.selectedTasks;

    Widget? appBarLeading() {
      if (selectedNote.isNotEmpty) {
        return IconButton(
          onPressed: () => notesBloc.add(UnselectAllNotes()),
          icon: const Icon(Icons.arrow_back_sharp),
        );
      } else if (selectedTasks.isNotEmpty) {
        return IconButton(
          onPressed: () => tasksBloc.add(UnselectAllTasks()),
          icon: const Icon(Icons.arrow_back_sharp),
        );
      } else {
        return null;
      }
    }

    Widget appBarTitle() {
      final titleString = selectedNote.isNotEmpty
          ? '${selectedNote.length}/${removedNotes.length} selected'
          : selectedTasks.isNotEmpty
              ? '${selectedTasks.length}/${removedTasks.length} selected'
              : 'Kotak Sampah';
      return Text(titleString);
    }

    List<Widget>? appBarActions() {
      if (selectedNote.isNotEmpty || selectedTasks.isNotEmpty) {
        return [
          IconButton(
            onPressed: () => selectedNote.isNotEmpty
                ? notesBloc.add(RestoreSelectedNotes())
                : tasksBloc.add(RestoreSelectedTasks()),
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
                  ? notesBloc.add(DeleteSelectedNotes())
                  : tasksBloc.add(DeleteSelectedTasks()),
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
                    ? notesBloc.add(SelectAllNotes())
                    : tasksBloc.add(SelectAllTasks()),
                child: const Text('Pilih Semua'),
              ),
            ],
          )
        ];
      } else {
        return null;
      }
    }

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
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(
          () {
            if (tabController.indexIsChanging ||
                tabController.animation!.value == tabController.index) {
              notesBloc.add(UnselectAllNotes());
              tasksBloc.add(UnselectAllTasks());
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
              labelStyle: Theme.of(context).textTheme.bodyText1,
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
