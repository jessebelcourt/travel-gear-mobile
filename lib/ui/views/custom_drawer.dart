import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:travel_gear_mobile/models/view_models.dart/drawer_view_model.dart';
import 'package:travel_gear_mobile/redux/app_state.dart';

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() {
    return _CustomAppDrawerState();
  }
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  ListView _buildDrawerContent(DrawerViewUIModel viewModel) {
    return ListView(
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
          child: ListTile(
            onTap: () => viewModel.navigateToUserProfile(),
            title: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    right: 5,
                  ),
                  child: Icon(Icons.account_circle),
                ),
                Text('View Profile'),
              ],
            ),
          ),
          //   child: Row(
          //     children: <Widget>[
          //       Container(
          //         padding: EdgeInsets.only(
          //           right: 5,
          //         ),
          //         child: Icon(Icons.account_circle),
          //       ),
          //       Text('View Profile'),
          //     ],
          //   ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => DrawerViewUIModel.fromStore(store),
      builder: (_, store) {
        return Drawer(
          child: _buildDrawerContent(store),
        );
      },
    );
  }
}
