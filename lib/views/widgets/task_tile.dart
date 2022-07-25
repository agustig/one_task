import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';
import '../../logic/logic.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            task.startTime.day != DateTime.now().day
                ? '${DateFormat.MMMMd('id_ID').format(task.startTime)} '
                : DateFormat('hh:mm a').format(task.startTime),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.read<TasksBloc>().add(UpdateTask(task: task));
                },
                icon: task.isDone
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.grey,
                      ),
              ),
              const Expanded(
                child: Divider(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 16,
                child: Card(
                  color: task.background,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          task.detail,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 8.0),
                        (task.startTime.year == task.endTime.year &&
                                task.startTime.month == task.endTime.month &&
                                task.startTime.day == task.endTime.day)
                            ? Text(
                                '${DateFormat("hh:mm a").format(task.startTime)} - '
                                '${DateFormat("hh:mm a").format(task.endTime)}',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            : Text(
                                '${DateFormat.MMMMd('id_ID').format(task.startTime)}, '
                                '${DateFormat("hh:mm a").format(task.startTime)} to\n'
                                '${DateFormat.MMMMd('id_ID').format(task.endTime)}, '
                                '${DateFormat("hh:mm a").format(task.endTime)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: 13),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Divider(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
