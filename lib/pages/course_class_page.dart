import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:catalyst/models/embed.dart';
import 'package:catalyst/models/course_class.dart';

class CourseClassPage extends StatefulWidget {
  @override
  _CourseClassPageState createState() => _CourseClassPageState();
}

class _CourseClassPageState extends State<CourseClassPage> {
  final double itemWidth = 800;
  final double itemHeight = 500;

  Future<Map> fetchYoutubeVideoData(courseClass) async {
    Map videoData = {};

    for (var id in courseClass.videos) {
      var response = await http.get(Uri.parse(
          r'https://youtube.com/oembed?format=json&url=youtube.com/watch?v=' +
              id));

      if (response.statusCode == 200) {
        videoData[id] = Embed.fromJson(response.body);
      } else {
        var placeholder = new Embed();
        placeholder.title = 'Vídeo não encontrado';
        placeholder.thumbnailUrl =
            r'https://via.placeholder.com/640x360.png/000000/ffffff/?text=Video+unavailable';
        videoData[id] = placeholder;
      }
    }

    return videoData;
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
            var videoData = snapshot.data as Map;

            return GridView.extent(
              maxCrossAxisExtent: itemWidth,
              childAspectRatio: itemWidth / itemHeight,
              padding: EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
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

    for (var entry in videoData.entries) {
      widgets.add(Card(
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.zero,
          child: Column(children: [
            InkWell(
              onTap: () async {
                await launch(r'https://youtube.com/watch?v=' + entry.key);
              },
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    entry.value.thumbnailUrl
                        .replaceAll('hqdefault', 'mqdefault'),
                    fit: BoxFit.fitWidth,
                  )),
            ),
            FittedBox(
                fit: BoxFit.fitHeight,
                child: Container(
                  width: itemWidth,
                  child: ListTile(
                    title: Text(
                      entry.value.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ))
          ])));
    }

    return widgets;
  }
}
