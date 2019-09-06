
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_music/variable.dart' as config;


class SingerPage extends StatefulWidget {
  SingerPage({Key key}) : super(key: key);

  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {

  List<Map> singerData = [];
  final HOT_NAME = "热门";
  final HOT_SINGER_LENGTH = 20;

  @override
  void initState() {
    MusicApi.getSingerList().then((val){
      var data = json.decode(val.toString());
      List<Map> singerList = (data['data']['list'] as List).cast();

      setState(() {
        singerData = singerList;
      });

      final nomallizeSinger = _nomallizeSinger(singerData);
      print(nomallizeSinger);

    });
    super.initState();
  }

  List _nomallizeSinger(List list){
    Map map = {
      'hot':{
        'title':HOT_NAME,
        'items':[]
      }
    };

    for (var index = 0; index < list.length; index++) {
      final item = list[index];

      if(index < HOT_SINGER_LENGTH){
        map['hot']['items'].add(
          {
            'id':item['Fsinger_mid'],
            'name':item['Fsinger_name'],
          }
        );
      }

      final key = item['Findex'];

      if(map[key] == null){
        map[key] = {
          'title':key,
          'items':[]
        };
      }

      map[key]['items'].add(
        {
          'id':item['Fsinger_mid'],
          'name':item['Fsinger_name'],
        }
      );
    }

    List ret = [];
    List hot = [];

    map.values.forEach((val){
      
      final title = val['title'];
      if(RegExp('[a-zA-Z]').hasMatch(title)){
        ret.add(val);
      }else if(val['title'] == HOT_NAME){
        hot.add(val);
      }
    });

    ret.sort((a, b){
      return a['title'].codeUnitAt(0) - b['title'].codeUnitAt(0);
    });
    
    return hot..addAll(ret);
  }

  Map<String,dynamic> singer(Map detals){
    return {
      'id':detals['id'],
      'name':detals['name'],
      'avatar':'https://y.gtimg.cn/music/photo_new/T001R150x150M000${detals['id']}.jpg?max_age=2592000',
    };
  }


  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.singer,
      listChildren: listChildren(),
    );
  }

  // 整体布局
  Widget listChildren(){
    return Stack(
      children: <Widget>[
        singerList(),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: screen.setWidth(40),
            alignment: Alignment.center,
            child: indexBar(),
          ),
        ),
      ],
    );
  }

  // 右边滑动列表
  Widget indexBar(){
    return GestureDetector(
      child: Container(
        width: screen.setWidth(40),
        padding: EdgeInsets.symmetric(vertical: screen.setHeight(20)),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, .3),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            barText('1'),
            barText('2'),
            barText('3'),
            barText('4'),
            barText('5'),
            barText('6'),
            barText('7'),
            barText('8'),
            barText('9'),
            barText('10'),
            barText('11'),
          ],
        ),
      ),
    );
  }

  Widget barText(index){
    return Container(
      padding: EdgeInsets.symmetric(vertical: screen.setHeight(6)),
      alignment: Alignment.center,
      child: Text(
        index,
        style: TextStyle(
          color: config.PrimaryFontColor,
          fontSize: screen.setSp(24),
        ),
      ),
    );
  }


  // 歌手列表
  Widget singerList(){
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            SizedBox(height: screen.setHeight(100)),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerTitle(),
            SizedBox(height: screen.setHeight(40)),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
            singerItem(),
          ],
        ),
        singerTitle(),
      ],
    );
  }

  Widget singerTitle(){
    return Container(
      width: screen.setWidth(750),
      height: screen.setHeight(60),
      color: config.BaseLightColor,
      padding: EdgeInsets.only(left: screen.setWidth(40)),
      alignment: Alignment.centerLeft,
      child: Text('header',
        style: TextStyle(
          color: config.PrimaryFontColor,
          fontSize: screen.setSp(24),
        ),
      ),
    );
  }

  // 歌手单个样式
  Widget singerItem(){
    return Container(
      padding: EdgeInsets.only(left: screen.setWidth(60),bottom: screen.setHeight(40)),
      child: Row(
        children: <Widget>[
          singerAvatar(),
          Expanded(
            child: singerName(),
          ),
        ],
      ),
    );
  }

  // 歌手头像
  Widget singerAvatar(){
    return ClipOval(
      child: Container(
        child: FadeInImage.memoryNetwork(
          placeholder:kTransparentImage,
          image: 'https://y.gtimg.cn/music/photo_new/T001R150x150M000002J4UUk29y8BY.jpg?max_age=2592000',
          fit: BoxFit.cover,
        ),
        height: screen.setHeight(100),
        width: screen.setWidth(100),
      ),
    );
  }

  // 歌手姓名
  Widget singerName(){
    return Container(
      padding: EdgeInsets.only(left: screen.setWidth(40)),
      child: Text('薛之谦',
        style: TextStyle(
          fontSize: screen.setSp(28),
          color: config.PrimaryFontColor,
        ),
      ),
    );
  }

}
