import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is BootstrapApplication) {
      UserModel user = await UserModel.userFromLocal;
    
      /// User authenticated bootstrap app
      if (await user.tokenIsValid) {
        store.dispatch(FetchUserDataAction());
      }

      store.dispatch(NavigateToGearView());
    }

    if (action is FetchUserDataAction) {
      print('fetch user data.....');
      // if (tokenIsSet && tokenIsValid['valid']) {
      //   UserModel user = tokenIsValid['user'];
      //   store.dispatch(UpdateUserInfo(user));
      // }
    }

    next(action);
  }
}
