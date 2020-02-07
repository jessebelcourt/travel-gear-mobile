import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:email_validator/email_validator.dart';
import 'package:travel_gear_mobile/models/data_models/user_model.dart';
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
  List<String> _errorsFromServer = [];
  AuthViewUIModel _viewModel;

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
                _buildRePasswordField(),
                _buildErrorMessage(),
                _buildSubmitButton(),
                _navigateToRegisterViewButton(viewModel),
                _buildRegistrationErrors(),
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
        style: TextStyle(decoration: TextDecoration.underline),
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
          onPressed: this._validateInputs,
          // onPressed: () {
          //   print(_viewModel);
          //   // this._validateInputs(viewModel);
          // },
          // onPressed: this._validateInputs,
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
        onChanged: this._validateEmailSubmission,
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

  Container _buildRegistrationErrors() {
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

  void _validatePasswords(String password) {
    if (_passwordConfirmationController.text != _passwordController.text) {
      setState(() {
        this._passwordError =
            this._passwordConfirmationError = 'Passwords must match';
      });
    } else {
      setState(() {
        this._passwordError = this._passwordConfirmationError = null;
      });
    }
  }

  void _validateEmailSubmission(String email) {
    if (email.isEmpty || email == null || EmailValidator.validate(email)) {
      setState(() => this._emailError = null);
    } else {
      setState(() => this._emailError = 'Please enter a valid email');
    }
  }

  void _validateInputs() {
    bool inputValid = true;
    // Email validation
    if (EmailValidator.validate(_emailController.text)) {
      print('email valid: ${_emailController.text}');
      print('submit email');
    } else {
      inputValid = false;
      setState(() => this._emailError = 'Please enter a valid email');
    }

    // Password validation
    if (_passwordController.text.isEmpty) {
      inputValid = false;
      setState(() => this._passwordError = 'Password cannot be blank');
    }

    if (_passwordConfirmationController.text.isEmpty) {
      inputValid = false;
      setState(() =>
          this._passwordConfirmationError = 'Confirmation cannot be blank');
    }

    if (_passwordController.text != _passwordConfirmationController.text) {
      setState(() {
        inputValid = false;
        this._passwordError =
            this._passwordConfirmationError = 'Passwords must match';
      });
    }

    if (_passwordController.text.isNotEmpty &&
        (_passwordController.text == _passwordConfirmationController.text)) {
      print('passwords are fine:');
      print('password: ${_passwordController.text}');
      print('password confirmation: ${_passwordConfirmationController.text}');
    }

    if (inputValid) {
      this._register({
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passwordConfirmationController.text,
      });
    }
  }

  void _register(Map<String, dynamic> data) async {
    UserModel user = await UserModel.userFromLocal;
    Map<String, dynamic> response = await user.register(data);
    print('_register: $response');

    if (response['errors'] != null && response['errors'].isNotEmpty) {
      setState(() => this._errorsFromServer = response['errors']);
    } else if (response['token'] != null && response['token'] != null ) {
      
      this._viewModel.fetchUserData();
    }
  }
}
