import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../logic/logic.dart';
import '../../services/services.dart';
import '../views.dart';

/// Halaman untuk menampilkan dan mengedit informasi pengguna
class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({Key? key}) : super(key: key);

  /// Widget popup dialog untuk Edit nama pengguna
  void _editNameDialog(BuildContext context, String name) {
    final textController = TextEditingController(text: name);
    final dialogTitle = Text(
      'Ubah nama',
      style: Theme.of(context).textTheme.displaySmall,
    );
    final dialogActions = [
      TextButton(
        onPressed: () {
          final nameIsZero = textController.text == '';
          final name = nameIsZero ? 'Tsubasa Ozora' : textController.text;
          context.read<UserCubit>().edit(name: name);
          Navigator.pop(context);
        },
        child: const Text('Simpan'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Batal'),
      ),
    ];

    // Menampilkan CupertinoAlertDialog jika platform iOS
    if (PlatformDetails().isIos) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: dialogTitle,
            content: BuildTextField(
              controller: textController,
              label: 'Name Lengkap',
              hint: 'Tsubasa Ozora',
              isIosField: true,
            ),
            actions: dialogActions,
          );
        },
        barrierDismissible: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: dialogTitle,
            content: BuildTextField(
                controller: textController,
                label: 'Name Lengkap',
                hint: 'Tsubasa Ozora'),
            actions: dialogActions,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();
    final fullNameController = TextEditingController(
      text: userCubit.state.user.name,
    );
    final hasImage = (userCubit.state.user.image != null);
    final String addButtonLabel = hasImage ? 'Ubah' : 'Tambah';

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  uploadImageDialog(
                    context: context,
                    onImageUploaded: (xImage) {
                      final imageFile =
                          LocalStore().saveFileToAppDocumentDirectory(
                        xImage.path,
                      );
                      userCubit.edit(image: imageFile);
                    },
                  );
                },
                child: const UserAvatar(
                  scale: 6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () {
                uploadImageDialog(
                  context: context,
                  onImageUploaded: (xImage) {
                    final imageFile =
                        LocalStore().saveFileToAppDocumentDirectory(
                      xImage.path,
                    );
                    userCubit.edit(image: imageFile);
                  },
                );
              },
              icon: const Icon(Icons.add_a_photo),
              child: Text('$addButtonLabel foto profil'),
            ),
            ...hasImage
                ? [
                    CustomTextButton(
                      onPressed: () => userCubit.removeImage(),
                      icon: const Icon(Icons.hide_image_rounded),
                      child: const Text('Hapus foto profil'),
                    ),
                  ]
                : [],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BuildTextField(
                    controller: fullNameController,
                    label: 'Nama Lengkap',
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 60,
                  child: CustomTextButton(
                    onPressed: () => _editNameDialog(
                      context,
                      fullNameController.text,
                    ),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
