import 'package:flutter/material.dart';

import 'package:catalyst/pages/course_page.dart';
import 'package:catalyst/pages/course_class_page.dart';

class AppRouter {
  static const courseRoute = '/';
  static const courseClassRoute = '/class';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case courseRoute:
        return MaterialPageRoute(
            builder: (_) => CoursePage(), settings: settings);
      case courseClassRoute:
        return MaterialPageRoute(
            builder: (_) => CourseClassPage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No page exists for ${settings.name}')),
                ));
    }
  }
}
