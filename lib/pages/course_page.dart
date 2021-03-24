import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:catalyst/main_router.dart';
import 'package:catalyst/main_drawer.dart';
import 'package:catalyst/models/course.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String coursesDirectory = 'rsc/courses/enem/';

  Future<List<Course>> loadCourses(path) async {
    var args = ModalRoute.of(context)!.settings.arguments;

    if (args is List<Course>) {
      return args;
    } else {
      List<Course> values = [];

      final assets =
          json.decode(await rootBundle.loadString('AssetManifest.json'));

      for (var asset in assets.keys) {
        if (asset.startsWith(path)) {
          values.add(Course.fromJson(await rootBundle.loadString(asset)));
        }
      }

      return values;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Matérias'),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return FutureBuilder(
      future: loadCourses(coursesDirectory),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              child: TreeView(
                  treeController: TreeController(allNodesExpanded: false),
                  nodes: buildContentNodes(snapshot.data as List<Course>)));
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text('Ocorreu um erro ao carregar as matérias.'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<TreeNode> buildContentNodes(List<Course> courses) {
    List<TreeNode> nodes = [];

    for (var course in courses) {
      var node = TreeNode(content: Text(course.title), children: []);

      if (course.classes.isNotEmpty) {
        for (var courseClass in course.classes) {
          node.children?.add(TreeNode(
              content: Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.courseClassRoute,
                    arguments: courseClass);
              },
              child: Text(courseClass.title),
            ),
          )));
        }
      }

      if (course.courses.isNotEmpty) {
        node.children?.addAll(buildContentNodes(course.courses));
      }

      nodes.add(node);
    }

    return nodes;
  }
}
