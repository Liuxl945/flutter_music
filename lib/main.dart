import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/route/application.dart';

void main() => runApp(RunApp());

class RunApp extends StatelessWidget {
  const RunApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: 'Chicken Music',
      theme: ThemeData(
        scaffoldBackgroundColor:config.BaseColor,
        // brightness: Brightness.dark,
      ),
      initialRoute: Routes.singerDetail,
      onGenerateRoute: router.generator,
    );
  }
}