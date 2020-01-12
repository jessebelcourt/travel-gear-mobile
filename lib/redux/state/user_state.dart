
import 'package:meta/meta.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';

@immutable
class UserState {
  final UserModel user;

  UserState({
    @required this.user,
  });

  factory UserState.initial() {
    return new UserState(
      user: null,
    );
  }

  UserState copyWith({
    UserModel user,
  }) {
    return new UserState(
      user: user ?? this.user,
    );
  }
}
