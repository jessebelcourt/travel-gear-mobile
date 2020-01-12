import 'package:flutter/material.dart';

class GearView extends StatefulWidget {
  GearView({Key key}) : super(key: key);

  @override
  _GearViewState createState() => _GearViewState();
}

class _GearViewState extends State<GearView> {
  bool _showAddGearButton = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Travel Gear',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_circle),
                    Text('View Profile'),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: _buildBottomTabBar(),
        ),
        appBar: _buildAppBar(),
        body: Container(
          child: TabBarView(
            children: <Widget>[
              _buildGearListView(),
              _buildAccountView(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildAccountView() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          height: 150,
                          child: Icon(
                            Icons.account_circle,
                            size: 68,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text('profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildGearListView() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Gear'),
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
            Icons.account_circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _addGear() {
    print('add gear.....');
  }
}
