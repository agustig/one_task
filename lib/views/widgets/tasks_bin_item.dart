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
    final selectedTasks = tasksBloc.state.selectedTasks;

    bool taskIsSelected(Task task) {
      return selectedTasks.contains(task);
    }

    bool removedTaskIsOnSelected() {
      return selectedTasks.isNotEmpty && selectedTasks[0].isRemoved;
    }

    void selectUnselectTask(Task task) {
      if (taskIsSelected(task)) {
        tasksBloc.add(UnselectTask(task: task));
      } else {
        tasksBloc.add(SelectTask(task: task));
      }
    }

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
            trailing: removedTaskIsOnSelected()
                ? Checkbox(
                    value: taskIsSelected(task),
                    onChanged: (_) => selectUnselectTask(task),
                  )
                : null,
            selected: taskIsSelected(task),
            onTap: removedTaskIsOnSelected()
                ? () => selectUnselectTask(task)
                : null,
            onLongPress: selectedTasks.isEmpty
                ? () => tasksBloc.add(SelectTask(task: task))
                : null,
          ),
        );
      },
    );
  }
}
