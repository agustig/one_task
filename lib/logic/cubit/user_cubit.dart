import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/user.dart';

part 'user_state.dart';

/// Cubit untuk me-manage [User]
class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserState());

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
