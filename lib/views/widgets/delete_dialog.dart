import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/services.dart';

/// Tipe penghapusan yang dipilih, terdapat dua opsi
/// * [remove]
/// * [delete]
enum DeleteType {
  /// Memindahkan ke kotak sampah
  remove,

  /// Menghapus selamanya/permanent
  delete,
}

/// Menampilkan dialog yang berisikan peringatan penghapusan
/// task atau note
void showDeleteDialog({
  required BuildContext context,
  required DeleteType type,
  required VoidCallback onSubmit,
}) {
  late String dialogTitle;
  late String dialogContent;
  late String dialogButtonString;

  switch (type) {
    case DeleteType.remove:
      dialogTitle = 'Pindahkan ke kotak sampah';
      dialogContent = 'Item akan dipindahkan ke kotak sampah. '
          'Anda dapat mengembalikan-nya kapanpun.';
      dialogButtonString = 'Pindahkah';
      break;
    case DeleteType.delete:
      dialogTitle = 'Hapus item';
      dialogContent =
          'Apakah anda yakin untuk menghapus selamanya catatan ini?';
      dialogButtonString = 'Hapus';
      break;
  }

  // Menampilkan CupertinoAlertDialog jika platform iOS
  if (PlatformDetails().isIos) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
                Navigator.pop(context);
              },
              child: Text(dialogButtonString),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
                Navigator.pop(context);
              },
              child: Text(dialogButtonString),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
