import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_music/route/handler.dart';

class Routes {
  static String recommend = '/';
  static String ranking = '/ranking';
  static String search = '/search';
  static String singer = '/singer';
  static String user = '/user';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,dynamic> params){
        print('ERROR=====>ROUTE WAS NOT FOUND'); 
        return null;
      }
    );

    router.define(recommend,handler: recommendHandler);
    router.define(ranking,handler: rankingHandler);
    router.define(search,handler: searchHandler);
    router.define(singer,handler: singerHandler);
    router.define(user,handler: userHandler);
  }
}
