import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';

class TabNav extends StatelessWidget {

  final String params;
  const TabNav({Key key, @required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoidCallback toRecommend = () => Application.router.navigateTo(context, Routes.recommend,transition: TransitionType.fadeIn);
    final VoidCallback toSinger = () => Application.router.navigateTo(context, Routes.singer,transition: TransitionType.fadeIn);
    final VoidCallback toRanking = () => Application.router.navigateTo(context, Routes.ranking,transition: TransitionType.fadeIn);
    final VoidCallback toSearch = () => Application.router.navigateTo(context, Routes.search,transition: TransitionType.fadeIn);


    return Container(
      child: Flex(
        direction:Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          tabItem(toRecommend,'推荐',0),
          tabItem(toSinger,'歌手',1),
          tabItem(toRanking,'排行',2),
          tabItem(toSearch,'搜索',3),
        ],
      ),
    );
  }

  Widget tabItem(VoidCallback onTap,String name,int index){
    return Expanded(
      flex:1,
      child: Container(
        height: screen.setHeight(88),
        decoration: BoxDecoration(
          color: config.BaseColor,
        ),
        child: linkDetector(onTap,name,index),
      )
    );
  }

  Widget linkDetector(VoidCallback onTap,String name,int index){
    int selectIndex = params == null ? 0 :
                      params == Routes.recommend ? 0 : 
                      params == Routes.singer ? 1 : 
                      params == Routes.ranking ? 2 : 3;
    return RaisedButton(
      onPressed:(){
        if(index == selectIndex) return;
        onTap();
      },
      color:config.BaseColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(name,
            style: TextStyle(
              fontSize: screen.setSp(30),
              color: index == selectIndex ? config.PrimaryColor : config.PrimaryFontColor,
            ),
          ),
          SizedBox(height: screen.setHeight(10)),
          Container(
            height: screen.setHeight(4),
            width: screen.setHeight(62),
            color: index == selectIndex ? config.PrimaryColor : config.BaseColor,
          ),
        ],
      ),
    );
  }
}
