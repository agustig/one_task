import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/user.dart';

part 'user_state.dart';

/// Cubit untuk me-manage [User]
class UserCubit extends HydratedCubit<UserState> {
  UserCubit()
      : super(
          // Inisiasi UserState dengan sampleUser
          UserState(user: User.sampleUser()),
        );

  /// Mengubah data [User]
  void edit({String? name, File? image}) {
    emit(
      UserState(
        user: state.user.copyWith(
          name: name,
          image: image,
        ),
      ),
    );
  }

  /// Menghapus gambar dari [User]
  void removeImage() {
    emit(UserState(user: state.user.removeImage()));
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
