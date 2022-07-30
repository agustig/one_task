import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import 'bin_screen.dart';

/// Drawer navigasi aplikasi
class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil state dari BLoC
    final userState = context.watch<UserCubit>().state.user;
    final removedNotes = context.watch<NotesBloc>().state.removedNotes;
    final removedTasks = context.watch<TasksBloc>().state.removedTasks;

    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(userState.image),
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userState.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const Divider(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profil'),
                    onTap: () {
                      // TODO: Tambah fungsi edit profil
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder_delete_outlined),
                    title: const Text('Kotak Sampah'),
                    trailing: Text(
                      '${removedNotes.length} note\n${removedTasks.length} task',
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BinScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Keluar'),
                    onTap: () {
                      // TODO: Tambah fungsi keluar/logout
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
