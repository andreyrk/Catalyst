import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('', () async {
    final assets =
        json.decode(await rootBundle.loadString('AssetManifest.json'));

    for (dynamic asset in assets.keys) {
      if (asset.startsWith("resources/courses/enem")) {
        final jsonObject = json.decode(await rootBundle.loadString(asset));
        expect(jsonObject['id'] is String, equals(true));
        expect(jsonObject['group'] is String, equals(true));
        expect(jsonObject['title'] is String, equals(true));
        expect(jsonObject['content'] is List, equals(true));
      }
    }
  });
}
