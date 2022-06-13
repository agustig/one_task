import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:one_task/theme.dart';
import 'package:one_task/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1Task',

      // Menerapkan custom tema
      theme: oneTaskTheme(),

      // Delegate untuk yang dibutuhkan untuk lokalisasi
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        SfGlobalLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Menentukan Indonesia sebagai lokasisasi yang didukung
      supportedLocales: const [Locale('id')],

      // Inisialisasi Indonesia sebagai lokalisasi
      locale: const Locale('id'),

      // Tampilan utama
      home: const Home(),
    );
  }
}
