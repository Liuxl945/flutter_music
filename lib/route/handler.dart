import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_music/pages/ranking.dart';
import 'package:flutter_music/pages/recommend.dart';
import 'package:flutter_music/pages/search.dart';
import 'package:flutter_music/pages/singer.dart';
import 'package:flutter_music/pages/user.dart';

final route = Router();

Handler recommendHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return RecommendPage();
  }
);

Handler rankingHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return RankingPage();
  }
);

Handler searchHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return SearchPage();
  }
);

Handler singerHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return SingerPage();
  }
);

Handler userHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return UserPage();
  }
);