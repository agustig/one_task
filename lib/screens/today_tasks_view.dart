import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:one_task/models/models.dart';

/// Menampilak task yang berlangsung hari ini
class TodayTasksView extends StatefulWidget {
  const TodayTasksView({Key? key, required this.tasksManager})
      : super(key: key);
  final UserTasksManager tasksManager;

  @override
  State<TodayTasksView> createState() => _TodayTasksViewState();
}

class _TodayTasksViewState extends State<TodayTasksView> {
  @override
  Widget build(BuildContext context) {
    final user = widget.tasksManager.user;
    final tasksToday = widget.tasksManager.todayTask;
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo ${user.name.split(' ')[0]}',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            'Ada ${tasksToday.length} task yang harus dikerjakan hari ini.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: tasksToday.map((task) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 45,
                          child: Text(
                            DateFormat('hh:mm a').format(task.startTime),
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
                                  setState(() {
                                    task.isDone = !task.isDone;
                                  });
                                },
                                icon: Icon(
                                  Icons.check_circle_outline_outlined,
                                  color:
                                      task.isDone ? Colors.green : Colors.grey,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          task.detail,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          '${DateFormat("hh:mm a").format(task.startTime)} - '
                                          '${DateFormat("hh:mm a").format(task.endTime)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
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
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
