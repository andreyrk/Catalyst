import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            title: Text(AppLocalizations.of(context).courses),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CoursePage.routeName);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).options),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CourseStructurePage.routeName);
            },
          )
        ],
      ),
    );
  }
}
