import 'package:flutter_music/api/api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PlayMusic extends StatefulWidget {
  final String mid;
  PlayMusic({Key key,@required this.mid}) : super(key: key);

  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  AudioPlayer audioPlayer = AudioPlayer();
  

  @override
  Widget build(BuildContext context){

    MusicApi.getMusicResult(widget.mid).then((val){
      Map data;
      try{
        data = json.decode(val.toString());
      }catch(e){
        data = json.decode(json.encode(val));
      }
      String url = data['req_0']['data']['midurlinfo'][0]['purl'];

      String songsUrl = 'http://dl.stream.qqmusic.qq.com/$url';
      
      audioPlayer.play(songsUrl);
    });

    return Container(
      height: 200,
      color: Colors.deepOrange,
      child: GestureDetector(
        onTap: (){
          audioPlayer.stop();
        },
        child: Text('dasdasdas'),
      ),
    );
  }
}