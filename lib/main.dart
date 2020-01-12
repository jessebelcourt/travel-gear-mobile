import 'package:flutter/material.dart';
import 'package:travel_gear_mobile/ui/views/gear_view.dart';
import 'package:travel_gear_mobile/ui/views/splash_view.dart';

void main() {
  runApp(TravelGearApp());
}

class TravelGearApp extends StatefulWidget {
  TravelGearApp({Key key}) : super(key: key);

  @override
  _TravelGearAppState createState() => _TravelGearAppState();
}

class _TravelGearAppState extends State<TravelGearApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.greenAccent
      ),
      initialRoute: '/gear',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashView(),
        '/gear': (BuildContext context) => GearView(),
      }
    );
  }
}