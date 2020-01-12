import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/redux/user_reducers.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducer(state.userState, action),
  );
}
