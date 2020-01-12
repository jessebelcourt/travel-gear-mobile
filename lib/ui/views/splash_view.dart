import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:travel_gear_mobile/models/view_models.dart/splash_view_model.dart';

class SplashView extends StatefulWidget {
  SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (store) => SplashViewUIModel.fromStore(store),
      builder: (_, viewModel) => _buildContent(viewModel),
      onInitialBuild: (viewModel) => viewModel.bootstrapApplication(),
    );
    // return _buildAppContent(context);
  }

  Scaffold _buildContent(SplashViewUIModel viewModel) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            'Travel Gear',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}
