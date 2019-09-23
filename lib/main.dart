import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/provide/banner_url.dart';
import 'package:flutter_music/provide/lyric.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/route/application.dart';
import 'package:provide/provide.dart';
import 'package:flutter_music/provide/singer.dart';

import 'provide/song.dart';

void main(){
  var providers = Providers();
  var singer = Singer();
  var bannerUrl = BannerUrl();
  var songState = SongState();
  var lyricState = LyricState();

  providers..provide(Provider<Singer>.value(singer));
  providers..provide(Provider<BannerUrl>.value(bannerUrl));
  providers..provide(Provider<SongState>.value(songState));
  providers..provide(Provider<LyricState>.value(lyricState));

  runApp(ProviderNode(
    providers: providers,
    child: RunApp(),
  ));
}

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
      initialRoute: Routes.singer,
      onGenerateRoute: router.generator,
    );
  }
}