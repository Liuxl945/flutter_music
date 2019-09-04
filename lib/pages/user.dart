import 'package:flutter/material.dart';
import 'package:flutter_music/base.dart';
import 'package:flutter_music/plugin/fit.dart';

final userPage = () => BodyPage.formBuild((ctx, params, router){

  return SafeArea(
    child: ListView(
      children: <Widget>[
        Text('search',
          style: TextStyle(
            fontSize: screen.setSp(55),
          ),
        )
      ],
    ),
  );
});