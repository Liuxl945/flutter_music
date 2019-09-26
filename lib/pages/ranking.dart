
import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/api/api.dart';


class RankingPage extends StatefulWidget {
  RankingPage({Key key}) : super(key: key);

  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {

  var _getTopList;

  @override
  void initState() {
    super.initState();
    _getTopList = MusicApi.getTopList();
  }

  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.ranking,
      listChildren: listChildren(),
    );
  }

  Widget listChildren(){
    return FutureBuilder(
      future: _getTopList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          List<Map> list = (data['data']['topList'] as List).cast();

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
            return rankingList(list[index],index == list.length-1);
           },
          );
        }else{
          return Container(
            height: screen.setWidth(300),
            child: Center(
              child: Text('暂时排行数据'),
            ),
          );
        }
      },
    );
  }

  // 排行列表
  Widget rankingList(rank,isLast){
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '${Routes.rankingDetail}?id=${rank['id']}', transition: TransitionType.fadeIn);
      },
      child: Container(
        
        margin: EdgeInsets.fromLTRB(screen.setWidth(40), screen.setWidth(40), screen.setWidth(40), isLast ? screen.setWidth(40): 0),
        color: config.BaseLightColor,
        child: Flex(
          direction:Axis.horizontal,
          children: <Widget>[
            leftImage(rank),
            Expanded(
              child: rightTitle(rank),
            )
          ],
        ),
      ),
    );
  }

  // 左边图片
  Widget leftImage(rank){
    return FadeInImage.memoryNetwork(
      placeholder:kTransparentImage,
      image:rank['picUrl'] ?? 'http://y.gtimg.cn/music/photo_new/T003R300x300M000003VJcf34ZETOl.jpg',
      fit: BoxFit.cover,
      width: screen.setWidth(200),
      height: screen.setWidth(200),
    );
  }

  // 右边文字
  Widget rightTitle(rank){
    int index = 1;
    List<Widget> list= [];

    for (var item in rank['songList']) {
      list.add(
        fontStyle('$index ${item['songname']}-${item['singername']}')
      );

      if(index < rank['songList'].length){
        list.add(
          SizedBox(height: screen.setWidth(24))
        );
        index++;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screen.setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list
      ),
    );
  }

  Widget fontStyle(title){
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:TextStyle(
        color: config.LightFontColor,
        fontSize: screen.setSp(24),
      ),
    );
  }
}