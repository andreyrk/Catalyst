import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:catalyst/models/embed.dart';
import 'package:catalyst/models/course_class.dart';

class CourseClassPage extends StatefulWidget {
  @override
  _CourseClassPageState createState() => _CourseClassPageState();
}

class _CourseClassPageState extends State<CourseClassPage> {
  Future<List> fetchYoutubeVideoData(courseClass) async {
    List data = [];

    for (var id in courseClass.videos) {
      var response = await http.get(Uri.parse(
          r'https://youtube.com/oembed?format=json&url=youtube.com/watch?v=' +
              id));

      if (response.statusCode == 200) {
        data.add(Embed.fromJson(response.body));
      } else {
        data.add(new Embed());
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var courseClass = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Aula'),
      ),
      body: buildContent(courseClass),
    );
  }

  Widget buildContent(courseClass) {
    if (courseClass is CourseClass) {
      return FutureBuilder(
        future: fetchYoutubeVideoData(courseClass),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var videoData = snapshot.data as List;

            return GridView.extent(
              maxCrossAxisExtent: 480,
              children: buildContentWidgets(videoData),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Ocorreu um erro ao carregar as aulas.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return Center(
        child: Text('A aula especificada não é válida.'),
      );
    }
  }

  List<Widget> buildContentWidgets(videoData) {
    List<Widget> widgets = [];

    for (var video in videoData) {
      widgets.add(Card(
        child: Image.network(video.thumbnailUrl),
      ));
    }

    return widgets;
  }
}
