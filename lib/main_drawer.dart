import 'package:flutter/material.dart';

import 'package:catalyst/main_router.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Courses'),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRouter.courseRoute);
            },
          ),
          ListTile(
            title: Text('Options'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
