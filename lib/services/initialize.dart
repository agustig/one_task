import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Direktori penyimpanan dokumen aplikasi
late final Directory documentDirectory;

/// Mengambil lokasi direkrori pada saat inisialisasi
Future<void> initialize() async {
  await getApplicationDocumentsDirectory().then(
    (docDir) => documentDirectory = docDir,
  );
}
