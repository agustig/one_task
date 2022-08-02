part of 'user_cubit.dart';

/// Data state yang di-manage oleh [UserCubit]
class UserState extends Equatable {
  const UserState({required this.user});

  final User user;

  /// Import [UserState] dari Json atau Map
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(user: User.fromJson(json['user']));
  }

  /// Export [UserState] ke dalam bentuk Json atau Map
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }

  @override
  List<Object> get props => [user];
}
