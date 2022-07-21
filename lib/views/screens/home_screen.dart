import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import 'screens.dart';

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
    return Scaffold(
      // Menghilanggkan tampilan appbar untuk halaman NotesView
      appBar: (currentPage == 2)
          ? null
          : AppBar(
              elevation: 0.0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(state.user.image),
                    );
                  },
                ),
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
            ),
      body: pages[currentPage],
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
            icon: Icon(Icons.home_filled),
            label: 'Home',
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
