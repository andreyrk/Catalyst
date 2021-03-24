import 'dart:convert';

import 'course_class.dart';

class Course {
  String id = '';
  String title = '';
  String category = '';

  List<Course> courses = [];
  List<CourseClass> classes = [];

  Course.fromJson(String jsonString) {
    Map map = json.decode(jsonString);

    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('category')) category = map['category'];

    if (map['courses'] is List) {
      for (var course in map['courses']) {
        courses.add(Course.fromJson(json.encode(course)));
      }
    }

    if (map['classes'] is List) {
      for (var courseClass in map['classes']) {
        classes.add(CourseClass.fromJson(json.encode(courseClass)));
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'courses': courses,
      'classes': classes,
    };
  }
}
