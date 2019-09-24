import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:provide/provide.dart';

class Lyric extends StatefulWidget {
  Lyric({Key key}) : super(key: key);

  _LyricState createState() => _LyricState();
}

class _LyricState extends State<Lyric> {
  List<Map> _formatLyric = [];//歌词
  int curNum = 0;//当前播放的歌词索引
  final int statePause = 0;
  final int statePlaying = 1;
  int state = 0; //是播放还是暂停
  int startStamp; //时间戳
  int pauseStamp;//暂停的时间

  Timer _countdownTimer;

  int _stamp2int(final String stamp) {
    final int indexOfColon = stamp.indexOf(":");
    final int indexOfPoint = stamp.indexOf(".");

    final int minute = int.parse(stamp.substring(1, indexOfColon));
    final int second = int.parse(stamp.substring(indexOfColon + 1, indexOfPoint));
    int millisecond;
    if (stamp.length - indexOfPoint == 2) {
      millisecond = int.parse(stamp.substring(indexOfPoint + 1, stamp.length)) * 10;
    } else {
      millisecond = int.parse(stamp.substring(indexOfPoint + 1, stamp.length - 1));
    }
    return ((((minute * 60) + second) * 1000) + millisecond);
  }

  int _findCurNum(time){
    for (var i = 0; i < _formatLyric.length; i++) {
      if (time <= _formatLyric[i]['time']) {
        return i;
      }
    }
    return this._formatLyric.length - 1;
  }

  List<Map> formatLyricFunc(lyric){
    final List lines = lyric.split('\n');
    RegExp pattern = RegExp(r"\[\d{2}:\d{2}.\d{2,3}]");
    
    for (var i = 0; i < lines.length; i++) {
      final String line = lines[i];
      var stamps = pattern.allMatches(line);
      var content = line.split(pattern).last;

      Map<String, dynamic> map = {};
      bool isOk = false;
      if(stamps.toString() != '()'){
        isOk = true;
        stamps.forEach((stamp){
          int timeStamp = _stamp2int(stamp.group(0));
          map['txt'] = content;
          map['time'] = timeStamp;
          if(content == ''){
            isOk = false;
          }
        });
      }
      if(isOk){
        _formatLyric.add(map);
      }
    }

    return _formatLyric;
  }

  void play({int startTime = 0}){
    if(_formatLyric.length == 0){
      return;
    }else{
      state = statePlaying;
      curNum = _findCurNum(startTime);
      startStamp = DateTime.now().microsecondsSinceEpoch - startTime;

      if(curNum < _formatLyric.length){
        _playRest();
      }
    }
  }

  void _playRest(){
    final line = _formatLyric[curNum];
    final int delay = line['time'] - (DateTime.now().microsecondsSinceEpoch - startStamp);

    _countdownTimer = Timer(Duration(milliseconds: delay),(){
      //执行滚动方法
      curNum++;
      
      if(curNum < _formatLyric.length && state == statePlaying){
        _playRest();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  Widget lyricRender(){
    return Provide<SongState>(builder: (context, child, counter){
      
      List<Map> formatLyric = _formatLyric = formatLyricFunc(counter.lyric); //格式化歌词
      print(counter.lyric);
      return Container(
        padding: EdgeInsets.only(bottom: screen.setHeight(20)),
        child: ListView.builder(
          itemCount: formatLyric.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: screen.setHeight(10)),
              child: Text(formatLyric[index]['txt'],
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, index == curNum ? 1 : .5),
                  fontSize: screen.setSp(28),
                ),
              ),
            );
          },
        ),
      );
    }); 
  }

  @override
  Widget build(BuildContext context) {
    SongState songState = Provide.value<SongState>(context);
    songState.setLyric();

    return lyricRender();
  }
}

