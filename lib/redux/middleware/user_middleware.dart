import 'package:flutter/foundation.dart';
// import 'package:justinClinic1/models/data_models/user_model.dart';
// import 'package:justinClinic1/redux/actions/navigation_actions.dart';
// import 'package:justinClinic1/redux/state/theme_actions.dart';
// import 'package:justinClinic1/util/api_connection.dart';
import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
// import 'package:justinClinic1/redux/actions/user_actions.dart';
// import 'package:justinClinic1/redux/app_state.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is BootstrapApplication) {

      print('bootsrtapping application...');
      // if (kIsWeb) {
      //   print('mocking web');
      //   ApiConnection api = ApiConnection();
      //   UserModel user = await api.getPreviewUser();
      //   store.dispatch(UpdateUserInfo(user));
      //   store.dispatch(NavigateToDashboard());
      //   store.dispatch(UpdateThemeData(action.config.theme));
      // } else {
      //   ApiConnection api = ApiConnection();

      //   // //Check to see if token is present...
      //   bool tokenIsSet = await api.tokenIsSet();
      //   Map<String, dynamic> tokenIsValid = await api.isTokenValid();

      //   if (tokenIsSet && tokenIsValid['valid']) {
      //     UserModel user = tokenIsValid['user'];
      //     store.dispatch(UpdateUserInfo(user));
      //     store.dispatch(UpdateThemeData(action.config.theme));
      //     store.dispatch(NavigateToDashboard());
      //   } else {
      //     store.dispatch(NavigateToLoginAction());
      //   }
      // }
    }

    next(action);
  }
}
