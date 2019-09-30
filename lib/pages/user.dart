import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/storage/i_like.dart' as storage;
import 'package:flutter_music/storage/recent_listen.dart' as storage1;
import 'package:flutter_music/widgets/play/mini_play.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/widgets/play/play_btn_content.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provide/provide.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  SwiperController controller = SwiperController();
  int swiperIndex = 0;


  @override
  Widget build(BuildContext context) {
    SongState songState = Provide.value<SongState>(context);


    // 回退按钮
    Widget backArrow(){
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          width: screen.setWidth(80),
          height: screen.setWidth(80),
          child: Icon(Icons.arrow_back_ios,size: screen.setSp(44),color: config.PrimaryColor),
        ),
      );
    }

    Widget navTab(){
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Color.fromRGBO(51, 51, 51, 1)),
          borderRadius:BorderRadius.all(
            Radius.circular(screen.setWidth(10)),
          )
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                controller.move(0);
                setState(() {
                  swiperIndex = 0;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: screen.setWidth(240),
                height: screen.setWidth(60),
                color: swiperIndex == 0 ? Color.fromRGBO(51, 51, 51, 1) : config.BaseColor,
                child: Text('我喜欢的',
                  style: TextStyle(
                    color: swiperIndex == 0 ? Colors.white : config.LightFontColor,
                    fontSize: screen.setSp(28),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                controller.move(1);
                setState(() {
                  swiperIndex = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: screen.setWidth(240),
                height: screen.setWidth(60),
                color: swiperIndex == 1 ? Color.fromRGBO(51, 51, 51, 1) : config.BaseColor,
                child: Text('最近听的',
                  style: TextStyle(
                    color: swiperIndex == 1 ? Colors.white : config.LightFontColor,
                    fontSize: screen.setSp(28),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }


    Widget listItem(Map item){

      return GestureDetector(
        onTap: () async{
          // 如果点击的是当前播放的歌曲则不暂停音乐
          if(item['id'] != songState.selectPlaying['id']){
            songState.addPlay(item);
            await songState.reloadPlay();
          }

          Application.router.navigateTo(context, Routes.disc,transition: TransitionType.fadeIn);
        },
        child: Container(
          color: config.BaseColor,
          padding: EdgeInsets.symmetric(horizontal: screen.setWidth(60)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item['name'] ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen.setSp(28),
                ),
              ),
              SizedBox(height: screen.setWidth(10)),
              Text('${item['singer']}·${item['album']}',
                style: TextStyle(
                  color: config.PrimaryFontColor,
                  fontSize: screen.setSp(28),
                ),
              )
            ],
          ),
        ),
      ); 
    }
    
    Widget listWrapper(Future<List<String>> data){
      return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            List iLike = json.decode(json.encode(snapshot.data)) ?? [];

            return ListView.builder(
              itemCount: iLike.length,
              itemBuilder: (BuildContext context, int index) {
                Map data = json.decode(iLike[index]);
                
                return Container(
                  padding: EdgeInsets.symmetric(vertical: screen.setWidth(20)),
                  child: listItem(data),
                );
              },
            );
          }else{
            return Container();
          }
        },
      );
      
    }

    Widget iLike(){
      Future<List<String>> data = storage.iLikeData();
      return Container(
        child: listWrapper(data),
      );
    }

    Widget recentListen(){
      Future<List<String>> data = storage1.recentData();
      return Container(
        child: listWrapper(data),
      );
    }


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: screen.setWidth(10)),
            Row(
              children: <Widget>[
                backArrow(),
                SizedBox(width: screen.setWidth(55)),
                navTab(),
              ],
            ),
            
            SizedBox(height: screen.setWidth(40)),
            Container(
              height: screen.setWidth(64),
              child: PlayBtnContent(color: config.PrimaryFontColor), //随机播放全部
            ),
            SizedBox(height: screen.setWidth(10)),
            
            Expanded(
              child: Swiper(
                controller:controller,
                itemCount: 2,
                onIndexChanged:(index){
                  setState(() {
                    swiperIndex = index; 
                  });
                },
                itemBuilder: (BuildContext context, int index){
                  if(index == 0){
                    return iLike();
                  }else{
                    return recentListen();
                  }
                },
              ),
            ),
            MiniPlay(),
          ],
        ),
      ),
    );
  }
}
