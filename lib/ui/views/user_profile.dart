import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({Key key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('user profile'),
      ),
    );
  }
}