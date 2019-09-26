
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/lyric.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/widgets/play/rotate_avatar.dart';
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

  int _scrollIndex = 0;

  @override
  Widget build(BuildContext context){
    SongState songState = Provide.value<SongState>(context);
    LyricState lyricState = Provide.value<LyricState>(context);

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
    Widget songCdImage(){
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
        child: RotateAvatar(),
        
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
      return Provide<SongState>(builder: (context, child, counter){
        return Container(
          height: screen.setHeight(100),
          width: screen.setWidth(600),
          child: Row(
            children: <Widget>[
              Container(
                width: screen.setWidth(70),
                child: Text(
                  counter.position != null ? (counter.position?.toString()?.substring(2,7)) : '00:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screen.setSp(24),
                  ),
                ),
              ),
              Container(
                width: screen.setWidth(460),
                height: screen.setHeight(8),
                // decoration: BoxDecoration(
                // color: Colors.deepOrange,
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(8),
                //   ),
                // ),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight:screen.setHeight(8),
                  ),
                  
                  child: Provide<SongState>(builder: (context, child, counter){
                    return Slider(
                      onChanged: (newValue) async{
                        // print(newValue);
                        await counter.changePosition(newValue);
                        lyricState.changePosition(counter.duration.inMilliseconds * newValue);
                      },
                      value: counter.sliderValue ?? 0,
                      activeColor:config.PrimaryColor,
                    );
                  }),
                  
                  
                )
                
                
              ),
              Container(
                width: screen.setWidth(70),
                alignment: Alignment.centerRight,
                child: Text(
                  counter.position != null ? (counter.duration?.toString()?.substring(2,7)) : '00:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screen.setSp(24),
                  ),
                ),
              )
            ],
          ),
        );
      });
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
                child: IconButton(
                  onPressed: (){
                    
                  },
                  icon: Icon(Icons.copyright,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async{
                    await songState.prev();
                    await lyricState.prevNext(songState.playlist[songState.currentIndex]['mid']);
                  },
                  icon: Icon(Icons.skip_previous,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                  ),
                ),
              ),
            ),
            Container(
              width: screen.setWidth(214),
              alignment:Alignment.center,
              child: IconButton(
                onPressed: (){
                  songState.togglePlaying();
                  lyricState.togglePlaying();
                },
                icon: Icon(Icons.play_circle_outline,
                color: config.PrimaryColor,
                size: screen.setSp(80),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () async{
                    await songState.next();
                    await lyricState.prevNext(songState.playlist[songState.currentIndex]['mid']);
                  },
                  icon: Icon(Icons.skip_next,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.favorite_border,
                  color: config.PrimaryColor,
                  size: screen.setSp(60),
                  ),
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
                    songCdImage(),
                    Container(
                      padding: EdgeInsets.only(top: screen.setHeight(60)),
                      child: Container(
                        width: screen.setWidth(600),
                        alignment: Alignment.center,
                        child: Provide<LyricState>(builder: (context, child, counter){
                          
                          return Text(counter.lyric.length > 0 ? counter.lyric[counter.curLine]['txt'] : '' ,
                            style: TextStyle(
                              color: config.PrimaryFontColor,
                              fontSize: screen.setSp(28),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Lyric();
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
            Provide<SongState>(builder: (context, child, counter){
              return bgImage(counter.playlist[counter.currentIndex]);
            }),
            
            gbFilter(),
            
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      backArrow(),
                      Provide<SongState>(builder: (context, child, counter){
                        return songTitle(counter.playlist[counter.currentIndex]);
                      }),
                      
                      SizedBox(width: screen.setHeight(80)),
                    ],
                  ),
                ),
                Provide<SongState>(builder: (context, child, counter){
                  return songSinger(counter.playlist[counter.currentIndex]);
                }),
                
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
            PlayMusic(),//播放音乐
          ],
        ),
      ),
    );
  }
}


