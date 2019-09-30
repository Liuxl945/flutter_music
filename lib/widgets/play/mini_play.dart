import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/lyric.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/widgets/play/rotate_avatar.dart';
import 'package:provide/provide.dart';

class MiniPlay extends StatelessWidget {
  const MiniPlay({Key key}) : super(key: key);


  Widget centerContent(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screen.setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: screen.setWidth(6)),
              child: Provide<SongState>(builder: (context, child, counter){
                return Text( counter.selectPlaying.toString() == '{}' ? '' : counter.selectPlaying['name'] ,
                  style: TextStyle(
                    fontSize: screen.setSp(28),
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: screen.setWidth(6)),
              alignment: Alignment.bottomLeft,
              child: Provide<LyricState>(builder: (context, child, counter){
                return Text(counter.lyric.length > 0 ? counter.lyric[counter.curLine]['txt'] : '',
                  style: TextStyle(
                    fontSize: screen.setSp(24),
                    color: config.LightFontColor,
                  ),
                );
              }),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget container(songState,lyricState){
    
    return Row(
      children: <Widget>[
        Container(
          height: screen.setWidth(80),
          width: screen.setWidth(80),
          child: RotateAvatar(),
        ),
        
        Expanded(
          child: centerContent(),
        ),
        GestureDetector(
          onTap: (){
            songState.togglePlaying();
            lyricState.togglePlaying();
          },
          child: Container(
            color: Color.fromRGBO(51, 51, 51, 1),
            width: screen.setWidth(100),
            height: screen.setWidth(80),
            child: Provide<SongState>(builder: (context, child, counter){
              return Icon(
                counter.playerState == PlayerState.playing ? Icons.pause_circle_outline : Icons.play_circle_outline,
                color: config.PrimaryColor,
                size: screen.setSp(80),
              );
            }),
          ),
        ),
      ],
    );
  } 

  @override
  Widget build(BuildContext context) {
    LyricState lyricState = Provide.value<LyricState>(context);
    SongState songState = Provide.value<SongState>(context);

    return Provide<SongState>(builder: (context, child, counter){
      return Offstage(
        offstage: counter.audioUrl == '',
        child: GestureDetector(
          onTap: (){
            Application.router.navigateTo(context, Routes.disc,transition: TransitionType.fadeIn);
          },
          child: Container(
            color: Color.fromRGBO(51, 51, 51, 1),
            padding: EdgeInsets.fromLTRB(screen.setWidth(40), screen.setWidth(10), screen.setWidth(20), screen.setWidth(10)),
            height: screen.setWidth(100),
            child: container(songState,lyricState),
          ),
        ),
      );
    });
    
  }
}