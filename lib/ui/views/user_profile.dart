import 'package:flutter/material.dart';
import 'package:travel_gear_mobile/ui/views/custom_drawer.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({Key key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      drawer: CustomAppDrawer(),
      body: Center(
        child: Text('user profile'),
      ),
    );
  }
}