import 'package:flutter/material.dart';

import '../../logic/logic.dart';

/// Mirip dengan [CircleAvatar], lingkaran yang menampikan gambar pengguna
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.scale,
  }) : super(key: key);

  final double? scale;

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;

    final hasImage = userState.user.image != null;

    return Container(
      height: 24 * (scale ?? 1),
      width: 24 * (scale ?? 1),
      decoration: BoxDecoration(
        color: userState.user.background,
        image: hasImage
            ? DecorationImage(
                image: FileImage(userState.user.image!),
                fit: BoxFit.cover,
              )
            : null,
        shape: BoxShape.circle,
      ),
      child: hasImage
          ? null
          : Center(
              child: Text(
                userState.user.name.split('')[0],
                style: TextStyle(
                    fontSize: 10 * (scale ?? 1),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}
