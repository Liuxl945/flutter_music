import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';


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

List<Map> formatLyricFunc(lyric){
  List<Map> newLyric = [];

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
      newLyric.add(map);
    }
  }
  return newLyric;
}

int _findCurNum(time,_formatLyric){
  for (var i = 0; i < _formatLyric.length; i++) {
    if (time <= _formatLyric[i]['time']) {
      return i;
    }
  }
  return _formatLyric.length - 1;
}

enum LyricMode { stopped, playing }

class LyricState with ChangeNotifier{

  List<Map> lyric = [];
  int curNum = 0;//当前播放的歌词索引
  int curLine = 0; //高亮歌词的索引
  LyricMode state = LyricMode.stopped; //是播放还是暂停
  int startStamp = 0; //时间戳
  int pauseStamp = 0;//暂停的时间
  Timer countdownTimer;

  _playRest(){
    final line = lyric[curNum];
    final int delay = line['time']*1000  - (DateTime.now().microsecondsSinceEpoch - startStamp);
    final int absDelay = delay.abs();

    countdownTimer = Timer(Duration(microseconds: absDelay),(){
      //执行滚动方法
      curNum++;
      curLine = curNum > 0 ? curNum - 1 : 0; 
      if(curNum < lyric.length && state == LyricMode.playing){
        _playRest();
      }
    });

    notifyListeners();
  }

  play({int startTime = 0,bool skipLast = false}){
    if(lyric.length == 0){
      return;
    }else{
      state = LyricMode.playing;
      curNum = _findCurNum(startTime,lyric);
      startStamp = DateTime.now().microsecondsSinceEpoch - startTime;

      if (!skipLast) {
        // 没传值
        // curNum--;
      }

      if(curNum < lyric.length){
        countdownTimer?.cancel();
        _playRest();
      }

    }
    notifyListeners();
  }

  togglePlaying(){
    int now = DateTime.now().microsecondsSinceEpoch;
    if(state == LyricMode.playing){
      stop();
      pauseStamp = now;
    }else{
      play(startTime:(pauseStamp ?? now) - (startStamp ?? now),skipLast:true);
      pauseStamp = 0;
    }
    notifyListeners();
  }


  stop(){
    state = LyricMode.stopped;
    print(state);
    countdownTimer?.cancel();
    notifyListeners();
  }


  setLyric(mid) async{
    final res = await MusicApi.getLyric(mid);
    Map data;
    try{
      data = json.decode(res.toString());
    }catch(e){
      data = json.decode(json.encode(res));
    }

    final String newLyric = utf8.decode(base64Decode(data['lyric']));
    
    lyric = formatLyricFunc(newLyric);
    notifyListeners();
  }
}