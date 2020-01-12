import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:travel_gear_mobile/models/view_models.dart/auth_view_model.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/ui/components/custom_app_bar.dart';
import 'package:travel_gear_mobile/ui/components/custom_drawer.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => AuthViewUIModel.fromStore(store),
      builder: (_, viewModel) => _buildContent(viewModel),
    );
  }

  Scaffold _buildContent(AuthViewUIModel viewModel) {
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
                _buildRePasswordField(),
                _buildSubmitButton(),
                _navigateToRegisterViewButton(viewModel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FlatButton _navigateToRegisterViewButton(AuthViewUIModel viewModel) {
    return FlatButton(
      child: Text(
        'Login',
      ),
      onPressed: viewModel.navigateToLoginView,
    );
  }

  Row _buildSubmitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
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
        'Sign Up',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Container _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
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

  Container _buildRePasswordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 28),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password again",
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
