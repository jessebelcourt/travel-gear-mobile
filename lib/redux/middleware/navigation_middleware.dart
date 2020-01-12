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
      Keys.navKey.currentState.pushNamedAndRemoveUntil('/userprofile', ModalRoute.withName('/gear'));
    }
    
    if (action is NavigateToGearView) {
      Keys.navKey.currentState.pushNamedAndRemoveUntil('/gear', ModalRoute.withName('/gear'));
    }

    // if (action is NavigateToAboutView) {
    //   switch (action.option) {
    //     case 'removeUntil':
    //       Keys.navKey.currentState
    //           .pushNamedAndRemoveUntil('/about', ModalRoute.withName('/about'));
    //       break;
    //     default:
    //       Keys.navKey.currentState.pushNamed("/about");
    //   }
    // }

    next(action);
  }
}
