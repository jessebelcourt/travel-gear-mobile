import 'package:flutter/material.dart';

class GearView extends StatefulWidget {
  GearView({Key key}) : super(key: key);

  @override
  _GearViewState createState() => _GearViewState();
}

class _GearViewState extends State<GearView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: _buildBottomTabBar(),
        ),
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Gear'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.list),
            Icon(Icons.list),
          ],
        ),
      ),
    );
  }

  TabBar _buildBottomTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
