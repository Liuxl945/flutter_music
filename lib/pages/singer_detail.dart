import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/singer.dart';
import 'package:flutter_music/utils/song.dart';
import 'package:flutter_music/widgets/music/music_list.dart';
import 'package:provide/provide.dart';


class SingerDetail extends StatefulWidget {
  final id;

  SingerDetail({Key key,@required this.id}) : super(key: key);

  _SingerDetailState createState() => _SingerDetailState();
}

class _SingerDetailState extends State<SingerDetail> {
  double imageHeight = screen.setHeight(525);
  double appbarHeight = screen.setHeight(88);
  var _getSingerDetail;

  @override
  void initState() {
    _getSingerDetail = MusicApi.getSingerDetail(widget.id);

    super.initState();
  }

  List _normalizeSongs(list){

    final ret = [];
    list.forEach((items){
      final item = items['musicData'];
      
      if(item['songid'] != null && item['albummid'] != null){
        ret.add(
          CreateSong.createSong(item)
        );
      }
    });
    return ret;
  }
  
  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height; //屏幕高度
    final screeTop = MediaQuery.of(context).padding.top; //安全区域高度

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screeHeight - screeTop,
          child: FutureBuilder(
            future: _getSingerDetail,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                var data = json.decode(snapshot.data.toString());

                Map<String,dynamic> cdlistList = (data['data'] as Map).cast();

                final singer = Provide.value<Singer>(context).singer;

                final String bgImage = singer['avatar'];
                final String title = singer['name'];
                final List songs = _normalizeSongs(cdlistList['list']);
                return MusicList(songs:songs,bgImage:bgImage,title:title);
              }else{
                return Container(
                  height: screeHeight - screeTop,
                  child: Center(
                    child: Text('暂时没有数据'),
                  ),
                );
              }
            }
          ),
        ),
      ),
    );
  }
}