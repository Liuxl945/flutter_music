
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.ranking,
      listChildren: ListView(
        children: <Widget>[
          Text('ranking',
            style: TextStyle(
              fontSize: screen.setSp(55),
            ),
          ),
        ],
      ),
    );
  }
}
