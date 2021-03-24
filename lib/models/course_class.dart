import 'dart:convert';

class CourseClass {
  String id = '';
  String title = '';
  String category = '';

  int priority = 0;
  List<String> videos = [];

  CourseClass.fromJson(String jsonString) {
    Map map = json.decode(jsonString);

    if (map.containsKey('priority')) priority = map['priority'];
    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('category')) category = map['category'];
    if (map.containsKey('videos')) videos = List<String>.from(map['videos']);
  }

  Map<String, dynamic> toJson() {
    return {
      'priority': priority,
      'id': id,
      'title': title,
      'category': category,
      'videos': videos,
    };
  }
}
