import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../models/task.dart';
import '../views.dart';

/// Laman form untuk menambahkan atau mengedit task.
///
/// Isikan parameter [oldTask] untuk mengedit.
class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    Key? key,
    this.oldTask,
  }) : super(key: key);

  final Task? oldTask;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  late Task _newTask;

  @override
  Widget build(BuildContext context) {
    final oldTask = widget.oldTask;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            oldTask != null ? 'Ubah task' : 'Tambah task baru',
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
          taskDateSelector(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _newTask = _newTask.copyWith(
                    title: _titleController.text,
                    detail: _detailController.text,
                  );

                  if (oldTask != null) {
                    context.read<TasksBloc>().add(EditTask(
                          oldTask: oldTask,
                          newTask: _newTask,
                        ));
                  } else {
                    context.read<TasksBloc>().add(AddTask(task: _newTask));
                  }

                  Navigator.pop(context);
                },
                child: Text(oldTask != null ? 'Edit' : 'Tambah'),
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

  Widget taskDateSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Mulai: ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 10.0),
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _newTask.startTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 1,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                  );

                  setState(() {
                    if (selectedDate != null) {
                      _newTask = _newTask.copyWith(
                        startTime: replaceDate(
                          _newTask.startTime,
                          selectedDate,
                        ),
                      );
                      taskTimeValidator();
                    }
                  });
                },
                child: Text(
                  DateFormat('dd/MM/yyy').format(_newTask.startTime),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_newTask.startTime),
                      initialEntryMode: TimePickerEntryMode.input,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true,
                          ),
                          child: child!,
                        );
                      });

                  setState(() {
                    if (selectedTime != null) {
                      _newTask = _newTask.copyWith(
                        startTime: replaceTime(
                          _newTask.startTime,
                          selectedTime,
                        ),
                      );
                      taskTimeValidator();
                    }
                  });
                },
                child: Text(
                  DateFormat.Hm().format(_newTask.startTime),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Akhir: ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 10.0),
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _newTask.endTime,
                    firstDate:
                        // Mengecek dan memastikan waktu akhir task harus
                        // sehabis waktu mulai
                        (_newTask.endTime.hour < _newTask.startTime.hour)
                            ? _newTask.endTime
                            : (_newTask.endTime.hour ==
                                        _newTask.startTime.hour &&
                                    _newTask.endTime.minute <=
                                        _newTask.startTime.minute)
                                ? _newTask.endTime
                                : _newTask.startTime,
                    lastDate: DateTime(
                      DateTime.now().year + 1,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                  );

                  setState(() {
                    if (selectedDate != null) {
                      _newTask = _newTask.copyWith(
                        endTime: replaceDate(
                          _newTask.endTime,
                          selectedDate,
                        ),
                      );
                      taskTimeValidator();
                    }
                  });
                },
                child: Text(
                  DateFormat('dd/MM/yyy').format(_newTask.endTime),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_newTask.endTime),
                      initialEntryMode: TimePickerEntryMode.input,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true,
                          ),
                          child: child!,
                        );
                      });

                  setState(() {
                    if (selectedTime != null) {
                      _newTask = _newTask.copyWith(
                        endTime: replaceTime(
                          _newTask.endTime,
                          selectedTime,
                        ),
                      );
                      taskTimeValidator();
                    }
                  });
                },
                child: Text(
                  DateFormat.Hm().format(_newTask.endTime),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Pengubah detail tanggal
  DateTime replaceDate(DateTime oldDate, DateTime newDate) {
    return DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      oldDate.hour,
      oldDate.minute,
    );
  }

  /// Pengubah detail jam
  DateTime replaceTime(DateTime oldDate, TimeOfDay newTime) {
    return DateTime(
      oldDate.year,
      oldDate.month,
      oldDate.day,
      newTime.hour,
      newTime.minute,
    );
  }

  /// Memeriksa dan memvalidasi waktu task
  void taskTimeValidator() {
    final startYear = _newTask.startTime.year;
    final startMonth = _newTask.startTime.month;
    final startDay = _newTask.startTime.day;
    final startHour = _newTask.startTime.hour;
    final startMinute = _newTask.startTime.minute;

    final endYear = _newTask.endTime.year;
    final endMonth = _newTask.endTime.month;
    final endDay = _newTask.endTime.day;
    final endHour = _newTask.endTime.hour;
    final endMinute = _newTask.endTime.minute;

    // Cek validitas tahun
    if (endYear < startYear) {
      _newTask = _newTask.copyWith(
        endTime: DateTime(
          startYear,
          startMonth,
          startDay,
          endHour,
          endMinute,
        ),
      );
    } else if (endYear == startYear) {
      // Cek validitas bulan
      if (endMonth < startMonth) {
        _newTask = _newTask.copyWith(
          endTime: DateTime(
            endYear,
            startMonth,
            startDay,
            endHour,
            endMinute,
          ),
        );
      } else if (endMonth == startMonth) {
        // Cek validitas hari
        if (endDay < startDay) {
          _newTask = _newTask.copyWith(
            endTime: DateTime(
              endYear,
              endMonth,
              startDay,
              endHour,
              endMinute,
            ),
          );
        } else if (endDay == startDay) {
          // Cek validitas jam
          if (endHour < startHour) {
            _newTask = _newTask.copyWith(
                endTime: _newTask.endTime.add(const Duration(days: 1)));
          } else if (endHour == startHour) {
            // Cek validitas menit
            if (endMinute <= startMinute) {
              _newTask = _newTask.copyWith(
                endTime: _newTask.endTime.add(const Duration(days: 1)),
              );
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final oldTask = widget.oldTask;

    // Mengisi data task lama jika oldTask tidak kosong
    if (oldTask != null) {
      _newTask = oldTask;
      _titleController.text = _newTask.title;
      _detailController.text = _newTask.detail;
    } else {
      _newTask = Task(
        title: '',
        detail: '',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(
          const Duration(hours: 1),
        ),
      );
    }
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
