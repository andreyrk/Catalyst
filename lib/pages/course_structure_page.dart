import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:catalyst/app_drawer.dart';
import 'package:flutter/material.dart';

class CourseStructurePage extends StatelessWidget {
  static const routeName = '/structure';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).courses),
      ),
    );
  }
}