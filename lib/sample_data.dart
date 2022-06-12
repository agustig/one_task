import 'package:intl/intl.dart';
import 'package:one_task/models/models.dart';

final userTaskManager = UserTasksManager(
  user: User(
    name: 'Agusti Gunawan',
    image: 'images/20210125_182525.jpg',
  ),
  tasks: <Task>[
    Task(
      title: 'Lari pagi',
      detail: 'Lari pagi rutin 1 minggu 3 kali, '
          'dilakukan setiap hari senin, rabu, jumat.',
      place: 'Jalan komplek rumah',
      startTime: timeConvert('06:45', -1),
      endTime: timeConvert('07:30', -1),
    ),
    Task(
      title: 'Persiapan buat kerja',
      detail: 'Mandi, sarapan, dan berkemas untuk kerja.',
      place: 'Area rumah',
      startTime: timeConvert('07:46', -1),
      endTime: timeConvert('08:30', -1),
    ),
    Task(
      title: 'Cek tugas yang dikerjakan',
      detail: 'Mengecek kembali tugas yang yang telah dikerjakan sebelumnya',
      place: 'Ruang kerja',
      startTime: timeConvert('08:30', -1),
      endTime: timeConvert('09:20', -1),
    ),
    Task(
      title: 'Menelpon rekan kerja',
      detail: 'Mendiskusikan rencana yang akan dilakukan dalam proyek yang '
          'sedang berlangsung.',
      place: 'Ruang kerja',
      startTime: timeConvert('09:20', -1),
      endTime: timeConvert('10:50', -1),
    ),
    Task(
      title: 'Mengerjakan tugas proyek',
      detail:
          'Melakukan implementasi berdasarkan hasil diskusi dengan rekan kerja.',
      place: 'Ruang kerja',
      startTime: timeConvert('10:50', -1),
      endTime: timeConvert('12:10', -1),
    ),
    Task(
      title: 'Istirahat Siang',
      detail: '',
      place: 'Ruang kerja',
      startTime: timeConvert('12:10', -1),
      endTime: timeConvert('13:10', -1),
    ),
    Task(
      title: 'Mengerjakan tugas proyek',
      detail: 'Melanjutkan pekerjaan sebelumnya',
      place: 'Ruang tengah',
      startTime: timeConvert('13:10', -1),
      endTime: timeConvert('15:30', -1),
    ),
    Task(
      title: 'Diskusi dengan Manager proyek',
      detail: 'Mendiskusikan dengan manager terkait aktivitas yang sudah '
          ' dikerjakan hari ini.',
      place: 'Ruang kerja',
      startTime: timeConvert('15:30', -1),
      endTime: timeConvert('16:50', -1),
    ),
    Task(
      title: 'Merancang desain flow chart aplikasi',
      detail: 'Merancang dalam garis besar flow chart aplikasi',
      place: 'Ruang kerja',
      startTime: timeConvert('08:45'),
      endTime: timeConvert('12:10'),
    ),
    Task(
      title: 'Istirahat Siang',
      detail: 'Lari pagi rutin 1 minggu 3 kali, '
          'dilakukan setiap hari senin, rabu, jumat.',
      place: 'Ruang kerja',
      startTime: timeConvert('12:10'),
      endTime: timeConvert('13:00'),
    ),
    Task(
      title: 'Merancang desain flow chart aplikasi',
      detail: 'Melanjutkan tugas sebelumnya',
      place: 'Ruang kerja',
      startTime: timeConvert('13:45'),
      endTime: timeConvert('14:50'),
    ),
    Task(
      title: 'Memeriksa kembali rancangan yang telah dikerjakan',
      detail: '',
      place: 'Ruang kerja',
      startTime: timeConvert('14:50'),
      endTime: timeConvert('16:00'),
    ),
    Task(
      title: 'Melapurkan ke manager',
      detail: 'Malaporkan pekerjaan yang telah dikerjakan',
      place: 'Ruang kerja',
      startTime: timeConvert('16:00'),
      endTime: timeConvert('17:00'),
    ),
    Task(
      title: 'Belanjar kebutuhan harian',
      detail: 'Berbelanja kebutuhan harian di supermarket kota',
      place: 'Kota',
      startTime: timeConvert('17:45'),
      endTime: timeConvert('20:30'),
    ),
    Task(
      title: 'Lari pagi',
      detail: 'Lari pagi rutin 1 minggu 3 kali, '
          'dilakukan setiap hari senin, rabu, jumat.',
      place: 'Jalan komplek rumah',
      startTime: timeConvert('06:45', 1),
      endTime: timeConvert('07:30', 1),
    ),
    Task(
      title: 'Melanjutkan mengerjakan belum rampung',
      detail: 'Melanjutkan pembuatan flow chart aplikasi.',
      place: 'Ruang kerja',
      startTime: timeConvert('08:30', 1),
      endTime: timeConvert('11:30', 1),
    ),
    Task(
      title: 'Menelepon rekan kerja',
      detail: 'Mananyakan pendapat tentang hasil dari desain flow chart.',
      place: 'Ruang kerja',
      startTime: timeConvert('11:30', 1),
      endTime: timeConvert('12:10', 1),
    ),
    Task(
      title: 'Istirahat siang',
      detail: '',
      place: 'Ruang istirahat',
      startTime: timeConvert('12:10', 1),
      endTime: timeConvert('13:00', 1),
    ),
    Task(
      title: 'Melakukan research tertang kebutuhan environtment proyek',
      detail: 'Research kebutuhan system environtment untuk proyek yang '
          'saat ini dikerjakan',
      place: 'Jalan komplek rumah',
      startTime: timeConvert('13:00', 1),
      endTime: timeConvert('16:20', 1),
    ),
  ],
);

/// Meng-conversi waktu berdasarkan waktu terdekat dari sekarang
/// dengan menginputkan jam, dan nilai perbedaan hari dengan hari ini.
DateTime timeConvert(String time, [int dayDifference = 0]) {
  final nowString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final customDate = DateFormat('yyyy-MM-dd HH:mm')
      .parse('$nowString $time')
      .subtract(Duration(days: -dayDifference));
  return customDate;
}
