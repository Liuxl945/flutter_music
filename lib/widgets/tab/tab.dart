import 'package:flutter/material.dart';
import 'package:flutter_music/router.dart';
import 'package:flutter_music/path.dart' as Path;
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;



class TabNav extends StatelessWidget {

  final Map params;
  const TabNav({Key key, @required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoidCallback toRecommend = () => route.to(context, Path.Recommend, {});
    final VoidCallback toSinger = () => route.to(context, Path.Singer, {});
    final VoidCallback toRanking = () => route.to(context, Path.Ranking, {});
    final VoidCallback toSearch = () => route.to(context, Path.Search, {});


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
    int selectIndex = params['path'] == null ? 0 :
                      params['path'] == Path.Recommend ? 0 : 
                      params['path'] == Path.Singer ? 1 : 
                      params['path'] == Path.Ranking ? 2 : 3;
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
