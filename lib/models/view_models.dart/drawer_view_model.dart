import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/redux/actions/navigation_actions.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

class DrawerViewUIModel {
  final Function navigateToUserProfile;
  final Function navigateToGearView;
  final UserModel user;

  DrawerViewUIModel({
    this.navigateToUserProfile,
    this.navigateToGearView,
    this.user,
  });

  static DrawerViewUIModel fromStore(Store<AppState> store) {
    return DrawerViewUIModel(
      navigateToUserProfile: () => store.dispatch(NavigateToUserProfileViewFromDrawer()),
      navigateToGearView: () => store.dispatch(NavigateToGearView()),
      user: store.state.userState.user,
    );
  }
}
