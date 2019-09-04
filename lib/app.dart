import 'package:flutter/material.dart';
import 'package:flutter_music/pages/ranking.dart';
import 'package:flutter_music/pages/recommend.dart';
import 'package:flutter_music/pages/search.dart';
import 'package:flutter_music/pages/singer.dart';
import 'package:flutter_music/pages/user.dart';
import 'package:flutter_music/router.dart';
import 'package:flutter_music/path.dart' as Path;
import 'package:flutter_music/variable.dart' as config;

class DemoApp extends StatelessWidget {
  static RouteFactory router = (RouteSettings settings){
    PageRoute widget;

    route.pages.forEach((path, page){
      if(path == settings.name){
        var args = settings.arguments;
        if(args == null){
          args = {
            'name': settings.name,
            'init': settings.isInitialRoute
          };
        }else{
          (args as Map)['path'] = settings.name;
          (args as Map)['init'] = false;
        }

        widget = page.build(args, route);
      }
    });
    return widget;
  };

  DemoApp(){
    route.add(Path.Recommend, recommendPage());
    route.add(Path.Ranking, rankingPage());
    route.add(Path.Singer, singerPage());
    route.add(Path.Search, searchPage());
    route.add(Path.User, userPage());
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primaryColor: config.BaseColor,
        dividerColor: config.BaseColor,
        backgroundColor:config.BaseColor,
        dialogBackgroundColor:config.BaseColor,
      ),
      initialRoute: Path.InitialRoute,
      onGenerateRoute: router,
    );
  }
}