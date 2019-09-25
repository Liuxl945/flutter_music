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

enum PlayerState { stopped, playing, paused }
enum PlayerMode { sequence, loop, random }

class SongState with ChangeNotifier{
  List playlist = [];//播放列表
  List sequenceList = [];//随机播放列表
  PlayerMode mode = PlayerMode.sequence;//播放模式
  int currentIndex = -1;//选中的歌曲列表下标
  bool playing = false;//是否播放
  bool fullScreen = false;//是否全屏显示
  AudioPlayer audioPlayer = AudioPlayer(); //歌曲播放控制器
  String audioUrl = '';
  Map selectPlaying = {};
  PlayerState playerState = PlayerState.stopped;

  Duration duration;
  Duration position;

  selectPlay(List list,int index){
    if(mode == PlayerMode.random){
      final List randomList = shuffle(list);
      playlist = randomList;
      index = findIndex(randomList,list[index]);
    }else{
      playlist = list;
    }
    selectPlaying = playlist[index];
    currentIndex = index;
    fullScreen = true;

    notifyListeners();
  }

  getAudioUrl() async{
    final val = await MusicApi.getMusicResult(playlist[currentIndex]['mid']);
    
    Map data;
    try{
      data = json.decode(val.toString());
    }catch(e){
      data = json.decode(json.encode(val));
    }
    String url = data['req_0']['data']['midurlinfo'][0]['purl'];
    audioUrl = 'http://dl.stream.qqmusic.qq.com/$url';

    notifyListeners();
  }

  stop() async{
    final result = await audioPlayer.stop();
    
    if (result == 1) {
      playerState = PlayerState.stopped;
      position = Duration();
      audioUrl = '';
    }
    notifyListeners();
  }

  reloadPlay() async{
    if(playerState == PlayerState.stopped && audioUrl == ''){

    }else{
      final result = await audioPlayer.stop();
      if(result == 1){
        position = Duration();
        playerState = PlayerState.stopped;
        audioUrl = '';
      }
      notifyListeners();
    }
    
  }

  initAudioPlayer() {

  }

  play() async {

    if(audioUrl == ''){
      await getAudioUrl();
    }

    final playPosition = (position != null &&
            duration != null &&
            position.inMilliseconds > 0 &&
            position.inMilliseconds < duration.inMilliseconds)
        ? position
        : null;
    int result = await audioPlayer.play(audioUrl,position: playPosition);
    if(result == 1){
      playerState = PlayerState.playing;
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
    notifyListeners();
  }

  pause() async{
    final result = await audioPlayer.pause();
    if(result == 1){
      playerState = PlayerState.paused;
    }
    notifyListeners();
  }

  prev() async{
    print('prev');
    if(playlist.length == 1){

    }else{
      int index = currentIndex - 1;
      if(index == -1){
        index = playlist.length - 1 ;
      }
      currentIndex = index;
      position = Duration();
      await stop();
      await play();
    }
    notifyListeners();
  }

  next() async{
    print('next');
    if(playlist.length == 1){
      // 循环播放
    }else{
      int index = currentIndex + 1;
      if(index == playlist.length){
        index = 0;
      }
      currentIndex = index;
      position = Duration();
      await stop();
      await play();
    }
    notifyListeners();
  }

  togglePlaying(){
    if(playerState == PlayerState.playing){
      playerState = PlayerState.paused;
    }else{
      playerState = PlayerState.playing;
    }
    playerState == PlayerState.playing ? play() : pause();

    notifyListeners();
  }

}