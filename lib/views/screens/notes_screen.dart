import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../views.dart';

/// Halaman untuk menampilkan semua note / catatan.
class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormDialog(context, const NoteFormScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      state.user.image,
                    ),
                  );
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
              ),
            ],
            elevation: 0,
            stretch: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Daftar catatan',
                style: Theme.of(context).textTheme.headline3,
              ),
              background: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${state.notes.length} catatan'),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
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
          ),
        ],
      ),
    );
  }
}
