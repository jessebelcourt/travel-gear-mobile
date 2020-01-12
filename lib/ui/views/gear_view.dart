import 'package:flutter/material.dart';

class GearView extends StatefulWidget {
  GearView({Key key}) : super(key: key);

  @override
  _GearViewState createState() => _GearViewState();
}

class _GearViewState extends State<GearView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('gear.....'),
      ),
    );
  }
}
