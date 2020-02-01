import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

class AuthViewUIModel {
  final Function navigateToLoginView;
  final Function navigateToRegisterView;
  final Function fetchUserData;

  AuthViewUIModel({
    this.navigateToLoginView,
    this.navigateToRegisterView,
    this.fetchUserData,
  });

  static AuthViewUIModel fromStore(Store<AppState> store) {
    return AuthViewUIModel(
      navigateToLoginView: () => store.dispatch(NavigateToUserProfileViewFromDrawer()),
      navigateToRegisterView: () => store.dispatch(NavigateToRegisterView()),
      fetchUserData: () => store.dispatch(FetchUserDataAction()),
    );
  }
}
