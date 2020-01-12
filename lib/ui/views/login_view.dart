import 'package:flutter/material.dart';
import 'package:travel_gear_mobile/ui/components/custom_app_bar.dart';
import 'package:travel_gear_mobile/ui/views/custom_drawer.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomAppDrawer(),
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      body: ListView(),
    );
  }
}
