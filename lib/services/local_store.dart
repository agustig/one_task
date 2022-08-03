import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'initialize.dart';

/// Class untuk menyimpan data pada direktori lokal
class LocalStore {
  final _appDocumentPath = documentDirectory.path;

  /// Menyimpan file pada direktori document aplikasi
  File saveFileToAppDocumentDirectory(String oldFilePath) {
    final oldFile = File(oldFilePath);
    final fileFormat = getFileBasename(oldFile).split('.').last;

    // Generate string untuk penamaan file
    final fileName = const Uuid().v1();
    final savedFile = oldFile.copySync(
      '$_appDocumentPath/$fileName.$fileFormat',
    );

    final fileBasename = getFileBasename(savedFile);

    /// Mehapus file dalam folder cache
    oldFile.deleteSync();

    return loadStoredFile(fileBasename);
  }

  /// Memuat file dari directory document aplikasi
  File loadStoredFile(String fileBasename) {
    return File('$_appDocumentPath/$fileBasename');
  }

  /// Mengambil nama base dari file
  static String getFileBasename(File file) {
    return p.basename(file.path);
  }
}
