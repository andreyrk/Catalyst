import 'dart:convert';

class Embed {
  String title = r'Vídeo não encontrado';
  String authorName = '';
  String authorUrl = '';
  String type = '';
  int height = 0;
  int width = 0;
  String version = '';
  String providerName = '';
  String providerUrl = '';
  int thumbnailHeight = 0;
  int thumbnailWidth = 0;
  String thumbnailUrl = '';
  String html = '';

  Embed() {}

  Embed.fromJson(String jsonString) {
    Map map = json.decode(jsonString);

    if (map.containsKey('title'))
      title = map['title'];

    if (map.containsKey('author_name'))
      authorName = map['author_name'];

    if (map.containsKey('author_url'))
      authorUrl = map['author_url'];

    if (map.containsKey('type'))
      type = map['type'];

    if (map.containsKey('height'))
      height = map['height'];

    if (map.containsKey('width'))
      width = map['width'];

    if (map.containsKey('version'))
      version = map['version'];

    if (map.containsKey('provider_name'))
      providerName = map['provider_name'];

    if (map.containsKey('provider_url'))
      providerUrl = map['provider_url'];

    if (map.containsKey('thumbnail_height'))
      thumbnailHeight = map['thumbnail_height'];

    if (map.containsKey('thumbnail_width'))
      thumbnailWidth = map['thumbnail_width'];

    if (map.containsKey('thumbnail_url'))
      thumbnailUrl = map['thumbnail_url'];

    if (map.containsKey('html'))
      html = map['html'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author_name': authorName,
      'author_url': authorUrl,
      'type': type,
      'height': height,
      'width': width,
      'version': version,
      'provider_name': providerName,
      'provider_url': providerUrl,
      'thumbnail_height': thumbnailHeight,
      'thumbnail_width': thumbnailWidth,
      'thumbnail_url': thumbnailUrl,
      'html': html
    };
  }
}
