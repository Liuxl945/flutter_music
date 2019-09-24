import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';

Map playMode = {
  'sequence': 0,
  'loop': 1,
  'random': 2
};

int getRandomInt(int min, int max){
  return (Random().nextDouble() * (max - min + 1) + min).floor();
}

List shuffle(List arr){
  List _arr = []..addAll(arr);

  for (var i = 0; i < _arr.length; i++) {
    final j = getRandomInt(0, i);
    final t = _arr[i];
    _arr[i] = _arr[j];
    _arr[j] = t;
  }
  return _arr;
}

int findIndex(List list, Map song){
  int index = 0;
  for (var i = 0; i < list.length; i++) {
    if(list[i]['id'] == song['id']){
      index = i;
      break;
    }
  }
  return index;
}


class SongState with ChangeNotifier{
  List playlist = [];//播放列表
  List sequenceList = [];//随机播放列表
  int mode = playMode['sequence'];//播放模式
  int currentIndex = -1;//选中的歌曲列表下标
  bool playing = false;//是否播放
  bool fullScreen = false;//是否全屏显示
  AudioPlayer audioPlayer = AudioPlayer(); //歌曲播放控制器
  String lyric = '';
  Duration duration;
  Duration position;

  selectPlay(List list,int index){
    if(mode == playMode['random']){
      final List randomList = shuffle(list);
      playlist = randomList;
      index = findIndex(randomList,list[index]);
    }else{
      playlist = list;
    }
    currentIndex = index;
    fullScreen = true;
    playing = true;

    notifyListeners();
  }
  stopSongs(){
    audioPlayer.stop();
    notifyListeners();
  }

  playSongs(String songsUrl) async {
    int result = await audioPlayer.play(songsUrl);
    if(result == 1){
      // success
      audioPlayer.onDurationChanged.listen((value){
        duration = value;
        notifyListeners();
      });

      audioPlayer.onAudioPositionChanged.listen((p){
        position = p;
        notifyListeners();
      });
    }
    // audioPlayer.resume();
    notifyListeners();
  }

  setLyric() async{
    final res = await MusicApi.getLyric(playlist[currentIndex]['mid']);
    Map data;
    try{
      data = json.decode(res.toString());
    }catch(e){
      data = json.decode(json.encode(res));
    }

    final String newLyric = utf8.decode(base64Decode(data['lyric']));

    lyric = newLyric;
    notifyListeners();
  }

  prev(){
    print('prev');
    if(playlist.length == 1){

    }else{
      int index = currentIndex - 1;
      if(index == -1){
        index = playlist.length - 1 ;
      }
      currentIndex = index;
      
      if(!playing){
        togglePlaying();
      }
    }
    setLyric();
    notifyListeners();
  }

  next(){
    print('next');
    if(playlist.length == 1){

    }else{
      int index = currentIndex + 1;
      if(index == playlist.length){
        index = 0;
      }
      currentIndex = index;
      
      if(!playing){
        togglePlaying();
      }
    }
    setLyric();
    notifyListeners();
  }

  togglePlaying(){
    playing = !playing;
    notifyListeners();
  }

}