
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_music/route/route.dart';


class RecommendPage extends StatefulWidget {
  RecommendPage({Key key}) : super(key: key);
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return CommonNavigation(
      params: Routes.recommend,
      listChildren: listChildren(context),
    );
  }

  // 轮播图+滑动列表
  Widget listChildren(context){
    return ListView(
      children: <Widget>[
        swiperBanner(),
        songList(),
      ],
    );
  }

  // 轮播图组件
  Widget swiperBanner() {
    return FutureBuilder(
      future: MusicApi.getRecomend(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          List<Map> swiperList = (data['data']['slider'] as List).cast();
          return swiperRender(swiperList);
        }else{
          return Container(
            height: screen.setHeight(300),
            child: Center(
              child: Text('暂时没有轮播图数据'),
            ),
          );
        }
      },
    );
  }

  Widget swiperRender(swiperList){
    return Container(
      height: screen.setHeight(300),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Hero(
            tag: swiperList[index]['picUrl'],
            child: FadeInImage.memoryNetwork(
              placeholder:kTransparentImage,
              image: swiperList[index]['picUrl'],
              fit: BoxFit.cover,
            ),
          );
        },
        onTap: (index){
          print(index);
        },
        loop: true,
        autoplay: true,
        itemCount: swiperList.length,
        pagination: SwiperPagination(),
      ),
    );
  }


  // 歌曲列表
  Widget songList(){
    return Column(
      children: <Widget>[
        Container(
          height: screen.setHeight(130),
          child: Center(
            child: Text('热门歌曲推荐',
              style: TextStyle(
                color: config.PrimaryColor,
                fontSize: screen.setSp(30),
              ),
            ),
          ),
        ),
        getSongData(),
      ],
    );
  }

  Widget getSongData(){
    return FutureBuilder(
      future: MusicApi.getDiscList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          
          List<Map> songList = (data['data']['list'] as List).cast();
          
          return songItems(songList);
        }else{
          return Container(
            child: Center(child: Text('暂时没有歌曲列表数据')),
          );
        }
      },
    );
  }

  Widget songItems(songList){
    List<Widget> list = [];
    for(int i = 0;i<songList.length;i++){
      list.add(
        songItem(songList[i]),
      );
    }

    return Column(
      children: list,
    );
  }

  // 单个歌曲
  Widget songItem(song){
    return GestureDetector(
      onTap: (){
        print(song);
      },
      child: Container(
        color: config.BaseColor,
        height: screen.setHeight(160),
        padding: EdgeInsets.fromLTRB(screen.setWidth(40), 0, screen.setWidth(40), screen.setWidth(40)),
        child: Flex(
          direction:Axis.horizontal,
          children: <Widget>[
            leftImage(song),
            rightText(song),
          ],
        ),
      ),
    );
    
    
  }

  Widget leftImage(song){
    return FadeInImage.memoryNetwork(
      placeholder:kTransparentImage,
      image:song['imgurl'],
      fit: BoxFit.cover,
      width: screen.setHeight(120),
      height: screen.setWidth(120),
    );
  }


  Widget rightText(song){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: screen.setWidth(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(song['creator']['name'] ?? '',style:TextStyle(
              color: Colors.white,
              fontSize: screen.setSp(28),
            )),
            SizedBox(height: screen.setHeight(26)),
            Text(song['dissname'] ?? '',style:TextStyle(
              color: config.PrimaryFontColor,
              fontSize: screen.setSp(24),
            )),
          ],
        ),
      ),
    );
  }

}