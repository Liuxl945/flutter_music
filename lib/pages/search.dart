
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.search,
      listChildren: ListView(
        children: <Widget>[
          Text('search',
            style: TextStyle(
              fontSize: screen.setSp(55),
            ),
          ),
        ],
      ),
    );
  }
}