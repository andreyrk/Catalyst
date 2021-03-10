import 'package:catalyst/pages/course_structure_page.dart';
import 'package:catalyst/pages/course_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalyst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        CoursePage.routeName: (_) => CoursePage(),
        CourseStructurePage.routeName: (_) => CourseStructurePage(),
      },
    );
  }
}
