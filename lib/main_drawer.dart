import 'package:flutter/material.dart';

import 'package:catalyst/pages/course_page.dart';
import 'package:catalyst/pages/course_structure_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Courses'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CoursePage.routeName);
            },
          ),
          ListTile(
            title: Text('Options'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CourseStructurePage.routeName);
            },
          )
        ],
      ),
    );
  }
}
