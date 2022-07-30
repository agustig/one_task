import 'package:flutter/material.dart';

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
  late String dialogButton;

  switch (type) {
    case DeleteType.remove:
      dialogTitle = 'Pindahkan ke kotak sampah';
      dialogContent = 'Item akan dipindahkan ke kotak sampah. '
          'Anda dapat mengembalikan-nya kapanpun.';
      dialogButton = 'Pindahkah';
      break;
    case DeleteType.delete:
      dialogTitle = 'Hapus item';
      dialogContent =
          'Apakah anda yakin untuk menghapus selamanya catatan ini?';
      dialogButton = 'Hapus';
      break;
  }
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
            child: Text(dialogButton),
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
