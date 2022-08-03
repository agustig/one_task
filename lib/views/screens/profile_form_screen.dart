import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/logic.dart';
import '../../services/services.dart';
import '../views.dart';

/// Halaman untuk menampilkan dan mengedit informasi pengguna
class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({Key? key}) : super(key: key);

  /// Widget popup dialog untuk upload/edit gambar
  void _uploadPhotoDialog(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ganti foto profil',
            style: Theme.of(context).textTheme.headline3,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Pilih foto dari galeri atau ambil dari kamera!'),
              const SizedBox(height: 20),
              CustomTextButton(
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then(
                    (xImage) {
                      if (xImage != null) {
                        final imageFile =
                            LocalStore().saveFileToAppDocumentDirectory(
                          xImage.path,
                        );
                        userCubit.edit(image: imageFile);
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
                      .pickImage(source: ImageSource.camera)
                      .then(
                    (xImage) {
                      if (xImage != null) {
                        final imageFile =
                            LocalStore().saveFileToAppDocumentDirectory(
                          xImage.path,
                        );
                        userCubit.edit(image: imageFile);
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
          ),
        );
      },
    );
  }

  /// Widget popup dialog untuk Edit nama pengguna
  void _editNameDialog(BuildContext context, String name) {
    final textController = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ubah nama',
            style: Theme.of(context).textTheme.headline3,
          ),
          content: BuildTextField(
            controller: textController,
            label: 'Name Lengkap',
            hint: 'Tsubasa Ozora',
          ),
          actions: [
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
          ],
        );
      },
    );
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
                onTap: () => _uploadPhotoDialog(context),
                child: const UserAvatar(
                  scale: 6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              onPressed: () => _uploadPhotoDialog(context),
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
