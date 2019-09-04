
import 'package:flutter/material.dart';
import 'package:flutter_music/base.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';

final singerPage = () => BodyPage.formBuild((ctx, params, router){
  
  return CommonNavigation(
    params: params,
    listChildren: ListView(
      children: <Widget>[
        Text('singer',
          style: TextStyle(
            fontSize: screen.setSp(55),
          ),
        ),
      ],
    ),
  );
});