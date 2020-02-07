import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/redux/navigation_key.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    // Login
    if (action is NavigateToGearView) {
      Keys.navKey.currentState.pushReplacementNamed("/gear");
    }

    if (action is NavigateToUserProfileViewFromDrawer) {
      // User must be logged in to view profile
      if (store.state.userState.user == null) {
        Keys.navKey.currentState.pushNamed('/login');
      } else {
        Keys.navKey.currentState.pushNamedAndRemoveUntil(
            '/userprofile', ModalRoute.withName('/gear'));
      }
    }

    if (action is PushToRegisterViewAction) {
      Keys.navKey.currentState.pushNamed('/register');
    }

    if (action is NavigateToLoginAction) {
      Keys.navKey.currentState.pushNamed('/login');
    }

    next(action);
  }
}
