import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../views.dart';

/// Hamalan utama aplikasi
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Pengatur tampilan menu utama
  var currentPage = 1;

  /// Halaman pada tampilan utama
  final pages = [
    const ScheduleScreen(),
    const TodayTasksScreen(),
    const NotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // List data judul halaman
    final titles = [
      const Text(
        'Skedul',
        style: TextStyle(fontSize: 27, color: Colors.black),
        textAlign: TextAlign.left,
      ),
      Text(
        'Halo ${context.watch<UserCubit>().state.user.name.split(' ')[0]}',
        style: const TextStyle(fontSize: 27, color: Colors.black),
      ),
      const Text(
        'Daftar catatan',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ];

    // List data sub judul halaman
    final subTitle = [
      const Text(''),
      Text('Ada ${context.watch<TasksBloc>().state.todayTasks.length} '
          'task yang harus dikerjakan hari ini.'),
      Text('${context.watch<NotesBloc>().state.notes.length} catatan'),
    ];

    // List FloatingActionButton yang digunakan di masing-masing halaman
    final floatingActionButtons = [
      FloatingActionButton(
        onPressed: () {
          showFormDialog(context, const TaskFormScreen());
        },
        child: const Icon(Icons.add),
      ),
      null,
      FloatingActionButton(
        onPressed: () {
          showFormDialog(context, const NoteFormScreen());
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    ];

    return Scaffold(
      floatingActionButton: floatingActionButtons[currentPage],
      drawer: const ProfileDrawer(),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  borderRadius: BorderRadius.circular(60),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: UserAvatar(),
                  ),
                );
              }),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
              ),
            ],
            elevation: 0,
            stretch: true,
            pinned: true,
            expandedHeight: 150,
            collapsedHeight: (currentPage == 2) ? null : 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: currentPage == 2,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 26,
              ),
              title: titles[currentPage],
              background: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: currentPage == 2
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [subTitle[currentPage]],
                ),
              ),
            ),
          ),
          pages[currentPage],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        iconSize: 35,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
