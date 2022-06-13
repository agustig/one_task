import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:one_task/screens/screens.dart';
import 'package:one_task/models/models.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({
    Key? key,
    required this.tasksManager,
  }) : super(key: key);
  final UserTasksManager tasksManager;

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman TaskFrom setelah itu refresh state
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskForm(taskManager: widget.tasksManager),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skedul',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SfCalendar(
                view: CalendarView.week,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.workWeek,
                  CalendarView.week,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                  CalendarView.timelineMonth,
                  CalendarView.schedule
                ],
                dataSource: TaskDataSource(widget.tasksManager.allTasks),
                scheduleViewSettings: ScheduleViewSettings(
                  appointmentTextStyle: Theme.of(context).textTheme.bodyText2,
                ),
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timelineAppointmentHeight: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Implementasi dari list [Task] ke [SfCalendar]
/// melalui [CalendarDataSource]
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(tasks) {
    appointments = tasks;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background ?? Colors.green;
  }
}
