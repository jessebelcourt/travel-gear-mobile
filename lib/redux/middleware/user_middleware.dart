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
      print('user from Bootstrap: $user');
    
      /// User authenticated, bootstrap app
      if (await user.tokenIsValid) {
        print('token is valid');
        await user.fetchData();
        store.dispatch(UpdateUserInfo(user));
      }

      store.dispatch(NavigateToGearView());
    }

    next(action);
  }
}
