import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/actions/user_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:redux/redux.dart';

class SplashViewUIModel {
  final Function navigateToLogin;
  final Function bootstrapApplication;

  SplashViewUIModel({
    this.navigateToLogin,
    this.bootstrapApplication,
  });

  static SplashViewUIModel fromStore(Store<AppState> store) {
    return SplashViewUIModel(
      navigateToLogin: () => store.dispatch(NavigateToLoginAction()),
      bootstrapApplication: () => store.dispatch(BootstrapApplication()),
    );
  }
}
