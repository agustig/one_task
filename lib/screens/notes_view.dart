import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_task/models/models.dart';
import 'package:one_task/screens/screens.dart';

/// Halaman untuk menampilkan semua note / catatan.
///
/// Paramenter inputan berupa [UserTasksManager]
class NotesView extends StatefulWidget {
  const NotesView({Key? key, required this.tasksManager}) : super(key: key);
  final UserTasksManager tasksManager;

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tombol untuk menambahkan note baru.
          // Setelah ditambahkan, state akan diperbarui
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteForm(
                tasksManager: widget.tasksManager,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  widget.tasksManager.user.image,
                ),
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
              title: Text(
                'Daftar catatan',
                style: Theme.of(context).textTheme.headline3,
              ),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${widget.tasksManager.allNotes.length} catatan'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate.fixed(
                widget.tasksManager.allNotes.map((note) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            // Ketika note ditekan(onTap), halaman akan berpindah
                            // ke halaman NoteForm untuk mengedit note.
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteForm(
                                    note: note,
                                  ),
                                ),
                              ).then((value) => setState(() {}));
                            },

                            // Ketika note dipendam(onLongPress), akan muncul peringatan
                            // hapus note yang bersangkutan.
                            onLongPress: () {
                              if (!Platform.isIOS) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Hapus catatan'),
                                      content: const Text(
                                        'Apakah anda yakin untuk menghapus catatan ini?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            widget.tasksManager.allNotes
                                                .remove(note);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Hapus'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Batal'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              } else {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: const Text('Hapus catatan'),
                                      content: const Text(
                                        'Apakah anda yakin untuk menghapus catatan ini?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            widget.tasksManager.allNotes
                                                .remove(note);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Hapus'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Batal'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              }
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
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              showNoteTime(note.createDate),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
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
