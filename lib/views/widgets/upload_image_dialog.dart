import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/services.dart';
import '../views.dart';

/// Widget popup dialog untuk upload/edit gambar
void uploadImageDialog({
  required BuildContext context,
  required Function(XFile) onImageUploaded,
}) {
  final dialogTitle = Text(
    'Ganti foto profil',
    style: Theme.of(context).textTheme.headline3,
  );
  final dialogContent = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text('Pilih foto dari galeri atau ambil dari kamera!'),
      const SizedBox(height: 20),
      CustomTextButton(
        onPressed: () async {
          await ImagePicker()
              .pickImage(
            source: ImageSource.gallery,
            imageQuality: 60,
          )
              .then(
            (xImage) {
              if (xImage != null) {
                onImageUploaded(xImage);
                Navigator.pop(context);
              }
            },
          );
        },
        icon: const Icon(Icons.image_search_outlined),
        width: 160,
        child: const Text('Galeri'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          '-- atau --',
          textAlign: TextAlign.center,
        ),
      ),
      CustomTextButton(
        onPressed: () async {
          await ImagePicker()
              .pickImage(
            source: ImageSource.camera,
            imageQuality: 60,
          )
              .then(
            (xImage) {
              if (xImage != null) {
                onImageUploaded(xImage);
                Navigator.pop(context);
              }
            },
          );
        },
        icon: const Icon(Icons.camera_alt_rounded),
        width: 160,
        child: const Text('Camera'),
      ),
    ],
  );

  // Menampilkan CupertinoAlertDialog jika platform iOS
  if (PlatformDetails().isIos) {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: dialogTitle,
          content: dialogContent,
        );
      },
      barrierDismissible: true,
    );
  } else {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: dialogTitle,
          content: dialogContent,
        );
      },
    );
  }
}
