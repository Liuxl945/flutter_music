import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/widgets/music/music_list.dart';
import 'package:flutter_music/utils/song.dart';

class RecommendDetail extends StatefulWidget {
  final id;
  RecommendDetail({Key key,@required this.id}) : super(key: key);
  _RecommendDetailState createState() => _RecommendDetailState();
}

class _RecommendDetailState extends State<RecommendDetail> {
  double imageHeight = screen.setHeight(525);
  double appbarHeight = screen.setHeight(88);
  var _getDisstList;

  @override
  void initState() {
    _getDisstList = MusicApi.getDisstList(widget.id);

    super.initState();
  }

  List _normalizeSongs(list){
    final ret = [];
    list.forEach((item){
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
            future: _getDisstList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                var data = json.decode(json.encode(snapshot.data));
                List<Map> cdlistList = (data['cdlist'] as List).cast();
                final Map cdlisData = cdlistList[0];

                final String bgImage = cdlisData['logo'];
                final String title = cdlisData['dissname'];
                final List songs = _normalizeSongs(cdlisData['songlist']);

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
