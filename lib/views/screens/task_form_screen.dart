import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../models/task.dart';
import '../views.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _dateTime = TaskTime();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Tambah task baru',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          BuildTextField(
            controller: _titleController,
            label: 'Judul',
            hint: 'Rapat',
          ),
          BuildTextField(
            controller: _detailController,
            label: 'Detail',
            hint: 'Rapat dengan client mengenai gol proyek',
            minLines: 2,
            maxLines: 3,
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
                          DateFormat.yMMMMEEEEd('id_ID').format(_dateTime.date),
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
                      child: const Text(
                        'Pilih tanggal',
                        style: TextStyle(),
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
                      child: const Text(
                        'Pilih jam',
                        style: TextStyle(),
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
                      child: const Text(
                        'Pilih jam',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Kotak yang akan muncul jika waktu akhir tidak valid
          SizedBox(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Mengecek terlebih dahulu apakah inputan waktu sudah valid
                  if (isEndTimeValid(_dateTime.startTime, _dateTime.endTime)) {
                    // Jika valid task akan ditambahkan ke dalam UserTaskManager
                    // dan kembali ke halaman sebelumnya
                    final newTask = Task(
                      title: _titleController.text,
                      detail: _detailController.text,
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
                    );

                    context.read<TasksBloc>().add(AddTask(task: newTask));
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
                child: const Text('Tambah'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Fungsi yang memeriksa apakah waktu berakhir task
  /// lebih awal dari waktu task dimulai.
  bool isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    if (end.hour - start.hour == 0) {
      if (end.minute - start.minute > 0) {
        return true;
      }
    } else if (end.hour - start.hour > 0) {
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    // Dispose untuk semua controller
    _titleController.dispose();
    _detailController.dispose();

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
