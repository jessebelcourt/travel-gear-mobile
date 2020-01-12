import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({this.scaffoldKey});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 32,
        ),
        onPressed: () => scaffoldKey.currentState.openDrawer(),
      ),
      centerTitle: true,
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
