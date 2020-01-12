import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_gear_mobile/redux/state/user_state.dart';

@immutable
class AppState extends Equatable {
  final UserState userState;

  AppState({
    @required this.userState,
  });

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
    );
  }

  AppState copyWith({
    UserState authState,
  }) {
    return AppState(
      userState: userState ?? this.userState,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
