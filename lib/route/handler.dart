import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_music/pages/banner_detail.dart';
import 'package:flutter_music/pages/ranking.dart';
import 'package:flutter_music/pages/ranking_detail.dart';
import 'package:flutter_music/pages/recommend.dart';
import 'package:flutter_music/pages/recommend_detail.dart';
import 'package:flutter_music/pages/search.dart';
import 'package:flutter_music/pages/singer.dart';
import 'package:flutter_music/pages/singer_detail.dart';
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

Handler bannerDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    return BannerDetail();
  }
);

Handler recommendDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    final id = params['id']?.first;
    return RecommendDetail(id:id);
  }
);

Handler rankingDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    
    return RankingDetail();
  }
);

Handler singerDetailHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    final id = params['id']?.first;
    return SingerDetail(id:id);
  }
);