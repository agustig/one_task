import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:one_task/models/models.dart';

UserTasksManager userTaskManager([bool randomColor = false]) {
  final random = Random();
  final taskManagers = UserTasksManager(
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
    notes: [
      Note(
        title: 'List Buku',
        noteBody: '1. Suteru Gijutsu\n2. Bisnis itu mudah\n'
            '3. Python Cookbook: Recipes for Mastering Python 3\n'
            '4. Fluent Python',
      ),
      Note(
        title: 'Bahan resep telur gulung korea',
        noteBody: '''* 4 butir telur ayam
* 1 batang daun bawang iris halus
* 50 gr wortel rebus, potong dadu kecil
* 1 sdt kaldu bubuk (mimi pakai kaldu dashi bubuk)
* 1 sdm kecap asin
* 1 sdt minyak wijen
* 1/4 sdt garam
* 1/2 sdt lada bubuk''',
      ),
      Note(
        title: 'Alamat Kantor Pos Sumur',
        noteBody:
            '''Alamat: Jl. Asia Afrika No.49, Braga, Kec. Sumur Bandung, Kota Bandung, Jawa Barat 40111
Jam buka: 08.00 - 16.00
Telepon: (022) 4207081''',
      ),
      Note(
        title: 'Urutan Anime Fate Series',
        noteBody: '''1. Fate/Zero (2011)
2. Fate/Stay Night (2006)
3. Fate/Stay Night: Unlimited Blade Works (2014)
4. Fate/Stay Night: Heaven Feels (2017)
5. Fate/Kaleid Liner Prisma Illya (2013-2016)
6. Fate/Apocrypha (2017)
7. Fate/Grand Order: First Order (2016)
8. Fate/Grand Order-Absolute Demonic Front: Babylonia (2019)
9. Fate/EXTRA: Last Encore (2018)
''',
      ),
      Note(
        title: 'Roadmap belajar flutter',
        noteBody: 'https://github.com/olexale/flutter_roadmap',
      ),
      Note(
        title: 'Passwd',
        noteBody: '''123456.
123456789.
qwerty.
password.
12345.
qwerty123.
1q2w3e.
12345678.''',
      ),
      Note(
        title: 'Kode Hongkong malam ini 😅',
        noteBody:
            '9308 02468 9328 91357 6217 13579 4113 57913 6801 57913 7243 68024 2840 24680 6034 68024',
      )
    ],
  );

  // Set warna random untuk setiap task dan note
  if (randomColor) {
    for (var task in taskManagers.allTask) {
      task.background =
          Colors.primaries[random.nextInt(Colors.primaries.length)]
              [(random.nextInt(5) * 100) + 100];
    }

    for (var note in taskManagers.allNotes) {
      note.background =
          Colors.primaries[random.nextInt(Colors.primaries.length)]
              [(random.nextInt(5) * 100) + 100];
    }
  }

  return taskManagers;
}

/// Meng-conversi waktu berdasarkan waktu terdekat dari sekarang
/// dengan menginputkan jam, dan nilai perbedaan hari dengan hari ini.
DateTime timeConvert(String time, [int dayDifference = 0]) {
  final nowString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final customDate = DateFormat('yyyy-MM-dd HH:mm')
      .parse('$nowString $time')
      .subtract(Duration(days: -dayDifference));
  return customDate;
}
