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
    final fileFormat = p.basename(oldFile.path).split('.').last;

    // Generate string untuk penamaan file
    final fileName = const Uuid().v1();
    final savedFile = oldFile.copySync(
      '$_appDocumentPath/$fileName.$fileFormat',
    );

    /// Mehapus file dalam folder cache
    oldFile.deleteSync();

    return savedFile;
  }
}
