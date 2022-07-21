import 'package:equatable/equatable.dart';

import '../../models/user.dart';
import '../logic.dart';

part 'user_state.dart';

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
