import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            bottom: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).primaryColor,
                child: Text('Logout'),
                onPressed: () {
                  print('logout of the application');
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
