import 'package:flutter/material.dart';

import 'package:catalyst/main_router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalyst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRouter.courseRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
