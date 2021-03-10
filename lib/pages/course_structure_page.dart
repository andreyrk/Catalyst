import 'package:catalyst/main_drawer.dart';
import 'package:flutter/material.dart';

class CourseStructurePage extends StatelessWidget {
  static const routeName = '/structure';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Courses'),
      ),
    );
  }
}