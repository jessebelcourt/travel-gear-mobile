import 'package:flutter/material.dart';

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
