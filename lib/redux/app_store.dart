import 'dart:async';
import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/app_reducer.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      // NavigationMiddleware(),
      // UserMiddleware(),
    ],
  );
}
