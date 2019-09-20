import 'package:flutter_music/api/api.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:provide/provide.dart';

class PlayMusic extends StatefulWidget {
  final String mid;
  PlayMusic({Key key,@required this.mid}) : super(key: key);

  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    
    SongState songState = Provide.value<SongState>(context);
    songState.stopSongs();

    MusicApi.getMusicResult(widget.mid).then((val){
      Map data;
      try{
        data = json.decode(val.toString());
      }catch(e){
        data = json.decode(json.encode(val));
      }
      String url = data['req_0']['data']['midurlinfo'][0]['purl'];
      String songsUrl = 'http://dl.stream.qqmusic.qq.com/$url';
      
      songState.playSongs(songsUrl);
    });
    return Container();    
  }
}