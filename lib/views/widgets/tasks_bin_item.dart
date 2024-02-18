import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../models/task.dart';
import 'widgets.dart';

/// Widget untuk menampilan task yang telah dihapus
class TasksBinItem extends StatelessWidget {
  const TasksBinItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksBloc = context.watch<TasksBloc>();
    final removedTasks = tasksBloc.state.removedTasks;
    final selectedTasks = tasksBloc.state.selectedBinTasks;

    void selectUnselectTask(Task task) => selectedTasks.contains(task)
        ? tasksBloc.add(UnselectBinTask(task: task))
        : tasksBloc.add(SelectBinTask(task: task));

    // Menampilkan pesan [EmptyItem] jika removedTasks kosong
    if (removedTasks.isEmpty) {
      return const EmptyItem(
        title: 'Tidak ada task',
        subTitle: 'Tekan tombol Tambah untuk membuat task.',
      );
    }

    return ListView.builder(
      itemCount: removedTasks.length,
      itemBuilder: (context, index) {
        final task = removedTasks[index];

        return Card(
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(task.detail),
            trailing: selectedTasks.isNotEmpty
                ? Checkbox(
                    value: selectedTasks.contains(task),
                    onChanged: (_) => selectUnselectTask(task),
                  )
                : null,
            selected: selectedTasks.contains(task),
            onTap: selectedTasks.isNotEmpty
                ? () => selectUnselectTask(task)
                : null,
            onLongPress: selectedTasks.isEmpty
                ? () => tasksBloc.add(SelectBinTask(task: task))
                : null,
          ),
        );
      },
    );
  }
}
