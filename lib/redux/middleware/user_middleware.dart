import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/util/api_connection.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is BootstrapApplication) {
      print('bootsrtapping application...');
      ApiConnection api = ApiConnection();

        //Check to see if token is present...
        bool tokenIsSet = await api.tokenIsSet();
        //TODO: Need to get backend auth wired up in order to continue
        Map<String, dynamic> tokenIsValid = await api.isTokenValid();

        if (tokenIsSet && tokenIsValid['valid']) {
          UserModel user = tokenIsValid['user'];
          store.dispatch(UpdateUserInfo(user));
          // store.dispatch(NavigateToDashboard());
        } else {
          store.dispatch(NavigateToLoginAction());
        }
      // }
    }

    next(action);
  }
}
