import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:one_task/models/models.dart';

/// Halaman untuk manambahkan atau mengedit Note.
///
/// Untuk menambahkah masukkan parameter [tasksManager],
/// sedangkan untuk mengedit note masukkan parameter [note],
class NoteForm extends StatefulWidget {
  const NoteForm({Key? key, this.note, this.tasksManager}) : super(key: key);
  final Note? note;
  final UserTasksManager? tasksManager;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _titleController = TextEditingController();
  final _noteBodyController = TextEditingController();
  Color _currentColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    // Memindahkan variabel dari parent ke child class
    final note = widget.note;
    final notes = widget.tasksManager?.allNotes;

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
                if (note != null) {
                  note.updateNote(
                    newTitle: _titleController.text,
                    newNoteBody: _noteBodyController.text,
                    newBackground: _currentColor,
                  );
                } else if (notes != null) {
                  final newNote = Note(
                    title: _titleController.text,
                    noteBody: _noteBodyController.text,
                    background: _currentColor,
                  );
                  notes.add(newNote);
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
              buildTextField(
                controller: _titleController,
                label: 'Judul',
                hint: 'Kontak pengacara',
              ),
              buildTextField(
                controller: _noteBodyController,
                label: 'Isi catatan',
                hint: '+62 852-428-43234',
                maxLines: 10,
              ),

              // Colom bagian untuk tombol pilih warna
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: BlockPicker(
                                pickerColor: Colors.green,
                                onColorChanged: (color) {
                                  setState(() => _currentColor = color);
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Simpan'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          _currentColor,
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                      ),
                      child: const Text('Pilih warna'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Fungsi untuk memformat inputan text.
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Inisiasi data state dengan data note sebelumnya
  // jika halaman digunakan sebagai edit/update.
  @override
  void initState() {
    super.initState();

    final note = widget.note;

    if (note != null) {
      _titleController.text = note.title;
      _noteBodyController.text = note.noteBody;
      _currentColor = note.background!;
    }
  }

  // Melakukan dispose pada controller
  @override
  void dispose() {
    _titleController.dispose();
    _noteBodyController.dispose();

    super.dispose();
  }
}
