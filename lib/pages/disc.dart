import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provide/provide.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:flutter_music/widgets/play/play.dart';
import 'package:flutter_music/widgets/play/lyric.dart';

class DiscPage extends StatefulWidget {
  DiscPage({Key key}) : super(key: key);

  _DiscPageState createState() => _DiscPageState();
}

class _DiscPageState extends State<DiscPage> {

  var _getLyric;
  int _scrollIndex = 0;


  @override
  Widget build(BuildContext context){
    SongState songState = Provide.value<SongState>(context);

    _getLyric = MusicApi.getLyric(songState.playlist[songState.currentIndex]['mid']);


    // 背景图片
    Widget bgImage(song){
      return Container(
        child: Image.network(song['image'] ?? 'http://y.gtimg.cn/music/photo_new/T002R300x300M000000MkMni19ClKG.jpg?max_age=2592000',
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        width: screen.setWidth(750),
        fit: BoxFit.fill,
        ),
      );
    }

    // 背景图片模糊
    Widget gbFilter(){
      return Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black54,
                  Colors.black26,
                  Colors.black45,
                  Colors.black87,
                ],
              ),
            ),
          )
        ),
      );
    }

    // 回退按钮
    Widget backArrow(){
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          width: screen.setWidth(80),
          height: screen.setHeight(80),
          child: Icon(Icons.expand_more,size: screen.setSp(64),color: config.PrimaryColor),
        ),
      );
    }

    // 歌曲标题
    Widget songTitle(song){
      return Expanded(
        child: Text(song['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            
            color: Colors.white,
            fontSize: screen.setSp(36),
          ),
        ),
      );
    }

    // 歌曲歌手
    Widget songSinger(song){
      return Container(
        child: Text(song['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: screen.setSp(28),
          ),
        ),
      );
    }

    // 歌曲CD图片
    Widget songCdImage(song){
      return Container(
        height: screen.setHeight(600),
        width: screen.setWidth(600),
        padding: EdgeInsets.all(screen.setWidth(20)),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, .15),
          borderRadius: BorderRadius.all(
            Radius.circular(300),
          ),
        ),
        child: ClipOval(
          child: Image.network(song['image']??'http://y.gtimg.cn/music/photo_new/T002R300x300M000000MkMni19ClKG.jpg?max_age=2592000',
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // 歌词CD切换控制器
    Widget lyricImageBar(int index){
      return Container(
        height: screen.setHeight(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screen.setWidth(index == 0 ? 40: 16),
              height: screen.setHeight(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                color: Color.fromRGBO(255, 255, 255, (index == 0 ? .8: .5)),
              ),
            ),
            SizedBox(width: screen.setWidth(20)),
            Container(
              width: screen.setWidth(index == 1 ? 40: 16),
              height: screen.setHeight(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                color: Color.fromRGBO(255, 255, 255, (index == 1 ? .8: .5)),
              ),
            )
          ],
        ),
      );
    }

    // 歌曲进度控制器
    Widget scrollBar(){
      return Container(
        height: screen.setHeight(100),
        width: screen.setWidth(600),
        child: Row(
          children: <Widget>[
            Container(
              width: screen.setWidth(60),
              child: Text('0:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen.setSp(24),
                ),
              ),
            ),
            Container(
              width: screen.setWidth(480),
              height: screen.setHeight(8),
              decoration: BoxDecoration(
              color: Colors.deepOrange,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            Container(
              width: screen.setWidth(60),
              alignment: Alignment.centerRight,
              child: Text('0:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen.setSp(24),
                ),
              ),
            )
          ],
        ),
      );
    }

    // 控制按钮
    Widget controlBtn(){
      return Container(
        height: screen.setHeight(80),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.copyright,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.skip_previous,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                ),
              ),
            ),
            Container(
              width: screen.setWidth(214),
              child: Container(
                child: Icon(Icons.play_circle_outline,
                  color: config.PrimaryColor,
                  size: screen.setSp(80),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.skip_next,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.favorite_border,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget cdLyricSwiper(){
      return Container(
        child: Swiper(
          outer:true,
          onIndexChanged: (index){
            if(index != _scrollIndex){
              setState(() {
                _scrollIndex = index;//歌词还是CD?
              });
            }
          },
          itemBuilder: (BuildContext context, int index){

            if(index == 0){
              return Container(
                child: Column(
                  children: <Widget>[
                    songCdImage(songState.playlist[songState.currentIndex]),
                    Container(
                      padding: EdgeInsets.only(top: screen.setHeight(60)),
                      child: Container(
                        width: screen.setWidth(600),
                        child: Text('曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦',
                          style: TextStyle(
                            color: config.PrimaryFontColor,
                            fontSize: screen.setSp(28),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Container(
                child: FutureBuilder(
                  future: _getLyric,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      Map data;
                      try{
                        data = json.decode(json.encode(snapshot.data));
                      }catch(e){
                        data = json.decode(snapshot.data.toString());
                      }

                      final String lyric = utf8.decode(base64Decode(data['lyric']));
                      songState.setLyric(lyric);

                      return Lyric(lyric: songState.lyric);
                    }else{
                      return Container();
                    }
                  },
                ),
              );
            }
            
          },
          itemCount: 2,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            bgImage(songState.playlist[songState.currentIndex]),
            gbFilter(),
            
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      backArrow(),
                      songTitle(songState.playlist[songState.currentIndex]),
                      SizedBox(width: screen.setHeight(80)),
                    ],
                  ),
                ),
                songSinger(songState.playlist[songState.currentIndex]),
                SizedBox(height: screen.setHeight(50)),
                Expanded(
                  child:cdLyricSwiper(),
                ),
                lyricImageBar(_scrollIndex),
                scrollBar(),
                controlBtn(),
                SizedBox(height: screen.setHeight(100)),
              ],
            ),
            // PlayMusic(mid: songState.playlist[songState.currentIndex]['mid'])
            
          ],
        ),
      ),
    );
  }
}
