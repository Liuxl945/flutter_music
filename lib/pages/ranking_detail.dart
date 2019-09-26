import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/utils/song.dart';
import 'package:flutter_music/widgets/music/music_list.dart';
class RankingDetail extends StatefulWidget {
  final id;
  RankingDetail({Key key,@required this.id}) : super(key: key);

  _RankingDetailState createState() => _RankingDetailState();
}

class _RankingDetailState extends State<RankingDetail> {
  double imageHeight = screen.setWidth(525);
  double appbarHeight = screen.setWidth(88);
  var _getMusicList;

  @override
  void initState() {
    _getMusicList = MusicApi.getMusicList(widget.id);

    super.initState();
  }

  List _normalizeSongs(list){
    final ret = [];
    list.forEach((items){
      final item = items['data'];
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
    print('${widget.id}================');

    final screeHeight = MediaQuery.of(context).size.height; //屏幕高度
    final screeTop = MediaQuery.of(context).padding.top; //安全区域高度

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screeHeight - screeTop,
          child: FutureBuilder(
            future: _getMusicList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                var data = json.decode(snapshot.data.toString());
                List<Map> songlist = (data['songlist'] as List).cast();
                Map songdetail = (data['topinfo'] as Map).cast();

                final List songs = _normalizeSongs(songlist);

                final String bgImage = songs[0]['image'];
                final String title = songdetail['ListName'];

                return MusicList(songs:songs,bgImage:bgImage,title:title,rank: true);
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