
import 'package:flutter/material.dart';
import 'package:flutter_music/base.dart';
import 'package:flutter_music/widgets/tab/header.dart';
import 'package:flutter_music/widgets/tab/tab.dart';
import 'package:flutter_music/plugin/fit.dart';


final recommendPage = () => BodyPage.formBuild((ctx, params, router){
  return SafeArea(
    child: ListView(
      children: <Widget>[
        Header(),
        TabNav(params:params),
        Text('recommend',
          style: TextStyle(
            fontSize: screen.setSp(55),
          ),
        )
      ],
    ),
  );
});