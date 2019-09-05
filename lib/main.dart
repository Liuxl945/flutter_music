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
      title: 'App',
      theme: ThemeData(
        primaryColor: config.BaseColor,
        dividerColor: config.BaseColor,
        backgroundColor:config.BaseColor,
        dialogBackgroundColor:config.BaseColor,
      ),
      initialRoute: Routes.recommend,
      onGenerateRoute: router.generator,
    );
  }
}