import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'logic/logic.dart';
import 'theme.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create:  (context) => NotesBloc()),
      ],
      child: MaterialApp(
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
        home: const HomeScreen(),
      ),
    );
  }
}
