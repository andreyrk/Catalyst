import 'package:flutter/material.dart';

import 'package:catalyst/pages/course_page.dart';

class AppRouter {
  static const courseRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case courseRoute:
        return MaterialPageRoute(
            builder: (_) => CoursePage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No page exists for ${settings.name}')),
                ));
    }
  }
}
