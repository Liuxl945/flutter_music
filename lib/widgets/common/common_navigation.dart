import 'package:flutter/material.dart';
import 'package:flutter_music/widgets/tab/header.dart';
import 'package:flutter_music/widgets/tab/tab.dart';

class CommonNavigation extends StatelessWidget {
  final params;
  final Widget listChildren;
  const CommonNavigation({Key key,@required this.params,@required this.listChildren}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(),
          TabNav(params:params),
          Expanded(
            child: listChildren,
          )
        ],
      ),
    );
  }
}