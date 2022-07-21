import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../widgets/task_tile.dart';

/// Menampilkan task yang berlangsung hari ini
class TodayTasksScreen extends StatelessWidget {
  const TodayTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Text(
                'Halo ${state.user.name.split(' ')[0]}',
                style: Theme.of(context).textTheme.headline1,
              );
            },
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return Text(
                'Ada ${state.todayTasks.length} task yang harus dikerjakan hari ini.',
                style: Theme.of(context).textTheme.bodyText2,
              );
            },
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: state.todayTasks.map((task) {
                        return TaskTile(task: task);
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
