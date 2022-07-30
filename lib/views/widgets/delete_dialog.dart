import 'package:flutter/material.dart';

enum DeleteType { remove, delete }

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
