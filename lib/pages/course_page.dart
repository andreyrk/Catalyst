import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:catalyst/main_drawer.dart';

class CoursePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<dynamic> courses = [];

  Future<void> loadCourses() async {
    final assets = json.decode(await rootBundle.loadString('AssetManifest.json'));

    for (dynamic asset in assets.keys) {
      if (asset.startsWith("resources/courses/enem")) {
        courses.add(json.decode(await rootBundle.loadString(asset)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadCourses();

    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Courses'),
        ),
        body: new ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return new ListTile(
                title: Text(courses[index]['title']),
              );
            }
        ),
    );
  }
}
