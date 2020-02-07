import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/state/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateUserInfo>(_updateUserInfo),
]);

UserState _updateUserInfo(UserState state, UpdateUserInfo action) {
  print(action.user);
  return state.copyWith(user: action.user);
}
// UserState _updateUserInfo(UserState state, UpdateUserInfo action) =>
//     state.copyWith(user: action.user);
