import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
import 'package:travel_gear_mobile/models/view_models.dart/auth_view_model.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';
import 'package:travel_gear_mobile/ui/components/custom_app_bar.dart';
import 'package:travel_gear_mobile/ui/components/custom_drawer.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String _emailErrorMessage;
  String _passwordErrorMessage;
  List<String> _errorsFromServer = [];
  AuthViewUIModel _viewModel;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => AuthViewUIModel.fromStore(store),
      builder: (_, viewModel) => _buildContent(viewModel),
      onInit: (store) {
        this._viewModel = AuthViewUIModel.fromStore(store);
      },
      onDidChange: (viewModel) {
        this._viewModel = viewModel;
      },
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
                _buildLoginButton(viewModel),
                _buildNavigateToRegisterViewButton(viewModel),
                _buildLoginErrors(),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  FlatButton _buildNavigateToRegisterViewButton(AuthViewUIModel viewModel) {
    return FlatButton(
      child: Text(
        'Sign up',
      ),
      onPressed: viewModel.navigateToRegisterView,
    );
  }

  Row _buildLoginButton(AuthViewUIModel viewModel) {
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
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          // onPressed: this._login,
          onPressed: () {
            this._login(viewModel);
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
      margin: EdgeInsets.only(bottom: 28),
      child: TextField(
        controller: this._passwordController,
        obscureText: true,
        decoration: InputDecoration(
          errorText: this._passwordErrorMessage,
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Container _buildLoginErrors() {
    List<Widget> errorWidgets = [];

    if (this._errorsFromServer != null && this._errorsFromServer.isNotEmpty) {
      errorWidgets = this._errorsFromServer.map((error) {
        return Container(
          child: Text(error),
        );
      }).toList();
    }

    return Container(
      child: Column(children: errorWidgets),
    );
  }

  Container _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: TextField(
        controller: this._emailController,
        onChanged: this._validateEmailOnChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorText: this._emailErrorMessage,
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _validateEmailOnChanged(String email) {
    if (email.isEmpty || email == null || EmailValidator.validate(email)) {
      setState(() => this._emailErrorMessage = null);
    } else {
      setState(() => this._emailErrorMessage = 'Please enter a valid email');
    }
  }

  bool _validateSubmission() {
    bool validInput = false;

    if (!EmailValidator.validate(_emailController.text)) {
      setState(() => this._emailErrorMessage = 'Please enter a valid email');
    } else {
      validInput = true;
    }

    if (_passwordController.text != null &&
        _passwordController.text.isNotEmpty) {
      validInput = true;
    } else {
      setState(() => this._passwordErrorMessage = 'Password cannot be empty');
    }

    return validInput;
  }

  void _login(AuthViewUIModel viewModel) async {
    if (this._validateSubmission()) {
      UserModel user = await UserModel.userFromLocal;
      Map<String, dynamic> loginResponse = await user.login({
        'email': _emailController.text,
        'password': _passwordController.text
      });
      if (loginResponse['token'] != null && loginResponse['token'].isNotEmpty) {
        await user.fetchData();
        viewModel.updateUserData(user);
        Navigator.pop(context);
      } else {
        setState(() => this._errorsFromServer.add('Incorrect email or password'));
        _emailController.clear();
        _passwordController.clear();
      }
    } else {
      print('ther was a problem.....');
    }
  }
}
