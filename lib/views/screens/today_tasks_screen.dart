import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../widgets/widgets.dart';

/// Menampilkan task yang berlangsung hari ini
class TodayTasksScreen extends StatelessWidget {
  const TodayTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          // Menampilkan pesan [EmptyItem] jika todayTasks kosong
          if (state.todayTasks.isEmpty) {
            return const EmptyItem(
              title: 'Tidak ada task',
              subTitle:
                  'Tekan tombol Tambah di laman Skejul untuk membuat task.',
              negativeHeight: 240,
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Column(
              children: state.todayTasks.map((task) {
                return TaskTile(task: task);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
