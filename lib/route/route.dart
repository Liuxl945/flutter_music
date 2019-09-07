import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_music/route/handler.dart';

class Routes {
  static String recommend = '/';
  static String ranking = '/ranking';
  static String search = '/search';
  static String singer = '/singer';
  static String user = '/user';
  static String bannerDetail = '/bannerDetail';
  static String recommendDetail = '/recommendDetail';
  static String rankingDetail = '/rankingDetail';
  static String singerDetail = '/singerDetail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('ERROR=====>ROUTE WAS NOT FOUND');
      return null;
    });

    router.define(recommend, handler: recommendHandler);
    router.define(ranking, handler: rankingHandler);
    router.define(search, handler: searchHandler);
    router.define(singer, handler: singerHandler);
    router.define(user, handler: userHandler);
    router.define(bannerDetail, handler: bannerDetailHandler);
    router.define(recommendDetail, handler: recommendDetailHandler);
    router.define(rankingDetail, handler: rankingDetailHandler);
    router.define(singerDetail, handler: singerDetailHandler);
  }
}
