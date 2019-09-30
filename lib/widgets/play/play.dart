import 'package:flutter/material.dart';
import 'package:flutter_music/provide/lyric.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:provide/provide.dart';

class PlayMusic extends StatefulWidget {
  PlayMusic({Key key}) : super(key: key);

  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {

  @override
  void initState() {
    super.initState();
  }

  initPlay(songState,lyricState) async{
    await songState.play();
    await lyricState.setLyric(songState.playlist[songState.currentIndex]['mid']);
    lyricState.play();
  }

  @override
  Widget build(BuildContext context){
    
    SongState songState = Provide.value<SongState>(context);
    
    LyricState lyricState = Provide.value<LyricState>(context);
    if(songState.playerState == PlayerState.stopped && songState.audioUrl == ''){
      initPlay(songState,lyricState);
    }
    
    // songState.getAudioUrl();
    // songState.play();
    // lyricState.setLyric(songState.playlist[songState.currentIndex]['mid']);
    
    return Container();    
  }
}