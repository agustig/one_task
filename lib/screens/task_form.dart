import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:one_task/models/models.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    Key? key,
    required this.taskManager,
  }) : super(key: key);

  final UserTasksManager taskManager;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _placeController = TextEditingController();
  final _dateTime = TaskTime();
  Color _currentColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: const Text('Tambah task baru'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                // Mengecek terlebih dahulu apakah inputan waktu sudah valid
                if (isEndTimeValid(_dateTime.startTime, _dateTime.endTime)) {
                  // Jika valid task akan ditambahkan ke dalam UserTaskManager
                  // dan kembali ke halaman sebelumnya
                  final newTask = Task(
                    title: _titleController.text,
                    detail: _detailController.text,
                    place: _placeController.text,
                    startTime: DateTime(
                      _dateTime.date.year,
                      _dateTime.date.month,
                      _dateTime.date.day,
                      _dateTime.startTime.hour,
                      _dateTime.startTime.minute,
                    ),
                    endTime: DateTime(
                      _dateTime.date.year,
                      _dateTime.date.month,
                      _dateTime.date.day,
                      _dateTime.endTime.hour,
                      _dateTime.endTime.minute,
                    ),
                    background: _currentColor,
                  );

                  widget.taskManager.addTask(newTask);
                  Navigator.pop(context);
                } else {
                  // Jika tidak valid, maka akan muncul SnackBar
                  // yang berisikan pesan tidak valid
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Inputan anda ada yang salah!'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              icon: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(
              controller: _titleController,
              label: 'Judul',
              hint: 'Rapat',
            ),
            buildTextField(
                controller: _detailController,
                label: 'Detail',
                hint: 'Rapat dengan client mengenai gol proyek',
                maxLines: 3),
            buildTextField(
              controller: _placeController,
              label: 'Tempat',
              hint: 'Cafe ABC',
            ),

            // Kolom untuk menampilkan tombol pilih tangal,
            // waktu mulai, dan waktu berakhir pada task
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tanggal:',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            DateFormat.yMMMMEEEEd('id_ID')
                                .format(_dateTime.date),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _dateTime.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );

                          setState(() {
                            if (selectedDate != null) {
                              _dateTime.date = selectedDate;
                            }
                          });
                        },
                        child: Text(
                          'Pilih tanggal',
                          style: TextStyle(
                            color: _currentColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Waktu mulai:',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            _dateTime.startTime.format(context),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final selectedTime = await showTimePicker(
                            context: context,
                            initialTime: _dateTime.startTime,
                          );

                          setState(() {
                            if (selectedTime != null) {
                              _dateTime.startTime = selectedTime;
                            }
                          });
                        },
                        child: Text(
                          'Pilih jam',
                          style: TextStyle(
                            color: _currentColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Waktu berakhir:',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(width: 10.0),
                          isEndTimeValid(_dateTime.startTime, _dateTime.endTime)
                              ? Text(
                                  _dateTime.endTime.format(context),
                                )
                              : Text(
                                  _dateTime.endTime.format(context),
                                  style: const TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final selectedTime = await showTimePicker(
                            context: context,
                            initialTime: _dateTime.endTime,
                          );

                          setState(() {
                            if (selectedTime != null) {
                              _dateTime.endTime = selectedTime;
                            }
                          });
                        },
                        child: Text(
                          'Pilih jam',
                          style: TextStyle(
                            color: _currentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Kolom untuk memilih warna yang akan diterapkan
            // pada latar belakang task
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Warna background',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: _currentColor,
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: BlockPicker(
                                  pickerColor: Colors.white,
                                  onColorChanged: (color) {
                                    setState(() => _currentColor = color);
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'Pilih warna',
                          style: TextStyle(color: _currentColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Kotak yang akan muncul jika waktu akhir tidak valid
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                child: Text(
                  isEndTimeValid(_dateTime.startTime, _dateTime.endTime)
                      ? ''
                      : 'Peringatan: Waktu berakhir harus lebih besar dari waktu mulai!',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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

  /// Fungsi yang memeriksa apakah waktu berakhir task
  /// lebih awal dari waktu task dimulai.
  bool isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    if (end.hour - start.hour <= 0) {
      if (end.minute - start.minute <= 0) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    // Dispose untuk semua controller
    _titleController.dispose();
    _detailController.dispose();
    _placeController.dispose();

    // Mamanggil fungsi dispose dari parent
    super.dispose();
  }
}

/// Class TaskTime sebagai referense object dari
/// waktu task yang digunakan.
class TaskTime {
  TaskTime() {
    date = DateTime.now();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay(hour: startTime.hour, minute: startTime.minute + 1);
  }

  late DateTime date;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
}
