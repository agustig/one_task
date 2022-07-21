part of 'user_cubit.dart';

class UserState extends Equatable {
  UserState({User? user}) : user = user ?? User.sampleUser();
  final User user;

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(user: User.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }

  @override
  List<Object> get props => [user];
}
