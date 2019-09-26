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
import 'package:flutter_music/variable.dart' as config;

class MiniPlay extends StatelessWidget {
  const MiniPlay({Key key}) : super(key: key);


  Widget centerContent(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screen.setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Provide<SongState>(builder: (context, child, counter){
            
            return Text( counter.selectPlaying != null ? counter.selectPlaying['name'] : '',
              style: TextStyle(
                fontSize: screen.setSp(28),
                color: Colors.white,
              ),
            );
          }),
          
          SizedBox(
            height: screen.setHeight(10),
          ),
          Provide<LyricState>(builder: (context, child, counter){
            return Text(counter.lyric.length > 0 ? counter.lyric[counter.curLine]['txt'] : '',
              style: TextStyle(
                fontSize: screen.setSp(24),
                color: config.LightFontColor,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget container(songState,lyricState){
    
    return Row(
      children: <Widget>[
        Container(
          height: screen.setHeight(80),
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
            width: screen.setWidth(100),
            height: screen.setHeight(80),
            child: Icon(
              Icons.play_circle_outline,
              color: config.PrimaryColor,
              size: screen.setSp(80),
            ),
          ),
        ),
        
        // GestureDetector(
        //   onTap: (){
        //     print('11111');
        //   },
        //   child: Container(
        //     width: screen.setWidth(100),
        //     height: screen.setHeight(80),
        //     color: Colors.deepOrange,
        //     child: Icon(
        //       Icons.airline_seat_legroom_extra,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
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
            padding: EdgeInsets.fromLTRB(screen.setHeight(40), screen.setHeight(20), screen.setHeight(20), screen.setHeight(20)),
            height: screen.setHeight(120),
            child: container(songState,lyricState),
          ),
        ),
      );
    });
    
  }
}