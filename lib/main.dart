import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:travel_gear_mobile/redux/navigation_key.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/redux/app_store.dart';
import 'package:travel_gear_mobile/ui/views/gear_view.dart';
import 'package:travel_gear_mobile/ui/views/login_view.dart';
import 'package:travel_gear_mobile/ui/views/register_view.dart';
import 'package:travel_gear_mobile/ui/views/settings_view.dart';
import 'package:travel_gear_mobile/ui/views/user_profile.dart';
import 'package:travel_gear_mobile/ui/views/splash_view.dart';

void main() async {
  var store = await createStore();
  runApp(TravelGearApp(store: store));
}

class TravelGearApp extends StatefulWidget {
  final Store<AppState> store;

  TravelGearApp({Key key, this.store}) : super(key: key);

  @override
  _TravelGearAppState createState() => _TravelGearAppState();
}

class _TravelGearAppState extends State<TravelGearApp> {
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: this.widget.store,
      child: MaterialApp(
        navigatorKey: Keys.navKey,
        theme: ThemeData(primaryColor: Colors.greenAccent),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashView(),
          '/gear': (BuildContext context) => GearView(),
          '/login': (BuildContext context) => LoginView(),
          '/register': (BuildContext context) => RegisterView(),
          '/userprofile': (BuildContext context) => UserProfileView(),
          '/settings': (BuildContext context) => SettingsView(),
        },
      ),
    );
  }
}
