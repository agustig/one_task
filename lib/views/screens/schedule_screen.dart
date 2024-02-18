import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../logic/logic.dart';
import '../../models/task.dart';
import '../views.dart';

/// Tampilan Jadwal task dalam bentuk kalender
/// menggunakan [SfCalendar]
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  /// Mengarahkan ke Edit task ketike item di-klik
  void onCalendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.agenda ||
        details.targetElement == CalendarElement.appointment) {
      final Task task = details.appointments![0];
      showFormModalBottom(context, TaskFormScreen(oldTask: task));
    }
  }

  /// Menampilkan fitur remove ketika item di-hold
  void onCalendarLongPressed(CalendarLongPressDetails details) {
    if (details.targetElement == CalendarElement.agenda ||
        details.targetElement == CalendarElement.appointment) {
      final Task task = details.appointments![0];
      showDeleteDialog(
        context: context,
        type: DeleteType.remove,
        onSubmit: () {
          context.read<TasksBloc>().add(RemoveTask(task: task));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height - 300,
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
                appointmentTextStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              monthViewSettings: const MonthViewSettings(showAgenda: true),
              timeSlotViewSettings: const TimeSlotViewSettings(
                timelineAppointmentHeight: 100,
              ),
              onTap: onCalendarTapped,
              onLongPress: onCalendarLongPressed,
            );
          },
        ),
      ),
    );
  }
}

/// Implementasi dari list [Task] ke [SfCalendar]
/// melalui [CalendarDataSource]
class TaskDataSource extends CalendarDataSource<Task> {
  TaskDataSource(List<Task> source) {
    appointments = source;
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
