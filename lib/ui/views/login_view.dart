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
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildViewLabel(),
                _buildEmailField(),
                _buildPasswordField(),
                _submitButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _submitButton(BuildContext context) {
    return Row(
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print('login');
                    },
                  ),
                ],
              );
  }

  Container _buildViewLabel() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      alignment: Alignment.center,
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Container _buildPasswordField() {
    return Container(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Container _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
