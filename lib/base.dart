import 'package:flutter/material.dart';
import 'package:flutter_music/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Widget BuildFn(BuildContext ctx, Map params, NoRoute router);

class BodyPage extends Page {
  BuildFn _build;
  bool noAnimate;
  String title;

  build(Map params, NoRoute router) {
    if(noAnimate){
      return PageRouteBuilder(
        pageBuilder: (ctx,_,__){
          ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(ctx);
          return Scaffold(
            body: _build(ctx, params, router),
          );
        }
      );
    }
    return MaterialPageRoute(builder: (ctx){
      ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(ctx);
      return Scaffold(
        body: _build(ctx, params, router),
      );
    });
  }

  BodyPage.formBuild(BuildFn build,{this.noAnimate = true,this.title}){
    


    _build = build;
  }
}