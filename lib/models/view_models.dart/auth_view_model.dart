import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

class AuthViewUIModel {
  final Function navigateToLoginView;
  final Function navigateToRegisterView;
  final Function fetchUserData;
  final Function updateUserData;

  AuthViewUIModel({
    this.navigateToLoginView,
    this.navigateToRegisterView,
    this.fetchUserData,
    this.updateUserData,
  });

  static AuthViewUIModel fromStore(Store<AppState> store) {
    return AuthViewUIModel(
      navigateToLoginView: () => store.dispatch(NavigateToUserProfileViewFromDrawer()),
      navigateToRegisterView: () => store.dispatch(PushToRegisterViewAction()),
      fetchUserData: () => store.dispatch(FetchUserDataAction()),
      updateUserData: (UserModel user) => store.dispatch(UpdateUserInfo(user)),
    );
  }
}
