import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:email_validator/email_validator.dart';
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
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _passwordConfirmationController;
  String _emailError;
  String _errorMessage = '';
  String _passwordError;
  String _passwordConfirmationError;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
  }

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
                _buildErrorMessage(),
                _buildSubmitButton(),
                _navigateToRegisterViewButton(viewModel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildErrorMessage() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
        left: 15,
        right: 15,
      ),
      child: Text(
        this._errorMessage ?? '',
        style: TextStyle(
          color: Colors.red[400],
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
        controller: this._passwordController,
        onChanged: this._validatePasswords,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          errorText: this._passwordError,
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
        controller: this._passwordConfirmationController,
        obscureText: true,
        onChanged: this._validatePasswords,
        decoration: InputDecoration(
          hintText: "Password again",
          errorText: this._passwordConfirmationError,
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
        bottom: 30,
      ),
      child: TextField(
        controller: _emailController,
        onChanged: this._validateEmailBeforeSubmission,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          errorText: this._emailError,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _validatePasswords(String password) {
    if (_passwordConfirmationController.text != _passwordController.text) {
      setState(() {
        this._passwordError = this._passwordConfirmationError = 'Passwords must match';
      });
    } else {
      setState(() {
        this._passwordError = this._passwordConfirmationError = null;
      });
    }
  }

  void _validateEmailBeforeSubmission(String email) {
    if (email.isEmpty || email == null || EmailValidator.validate(email)) {
      setState(() => this._emailError = null);
    } else  {
      setState(() => this._emailError = 'Please enter a valid email');
    }
  }
}
