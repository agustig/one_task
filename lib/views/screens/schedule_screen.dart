import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../logic/logic.dart';
import '../../models/task.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height - 240,
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return SfCalendar(
              view: CalendarView.schedule,
              allowedViews: const [
                CalendarView.day,
                CalendarView.week,
                CalendarView.month,
                CalendarView.timelineWeek,
                CalendarView.schedule
              ],
              dataSource: TaskDataSource(state.allTasks),
              scheduleViewSettings: ScheduleViewSettings(
                appointmentTextStyle: Theme.of(context).textTheme.bodyText2,
              ),
              monthViewSettings: const MonthViewSettings(showAgenda: true),
              timeSlotViewSettings: const TimeSlotViewSettings(
                timelineAppointmentHeight: 100,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Implementasi dari list [Task] ke [SfCalendar]
/// melalui [CalendarDataSource]
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Task> tasks) {
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
    return appointments![index].background;
  }
}
