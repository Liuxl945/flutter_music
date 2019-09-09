import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;

class SongList extends StatefulWidget {
  final List songs;
  final bool rank;

  SongList({Key key,@required this.songs,this.rank = false}) : super(key: key);

  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: listViewChildren(widget.songs),
      ),
    );
  }

  // 图标
  List<Widget> listViewChildren(List item){
    List<Widget> list = [];

    Widget boxContainer({child}){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: screen.setWidth(60)),
        alignment: Alignment.centerLeft,
        height: screen.setHeight(128),
        child: child,
      );
    }

    if(widget.rank){
      for (var i = 0; i < item.length; i++) {
        list.add(
          boxContainer(
            child:Row(
              children: <Widget>[
                leftRanking(i),
                Expanded(
                  child: songDetail(item[i]),
                ),
              ],
            ),
          )
        );
      }
    }else{
      for (var i = 0; i < item.length; i++) {
        list.add(
          boxContainer(
            child:songDetail(item[i]),
          )
        );
      }
    }

    return list;
  }

  Widget songDetail(Map song){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          song['name'],
          style: TextStyle(
            color: Colors.white,
            fontSize: screen.setSp(28),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: screen.setHeight(20)),
        Text(
          '${song['singer']}.${song['album']}',
          style: TextStyle(
            color: config.PrimaryFontColor,
            fontSize: screen.setSp(28),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget leftRanking(int i){
    return Container(
      alignment: Alignment.center,
      width: screen.setWidth(75),
      height: screen.setWidth(50),
      margin: EdgeInsets.only(right: screen.setWidth(35)),
      child: i<3 ? rankImage(i): rankText(i),
    );
  }

  Widget rankImage(i){
    final name = i == 0 ? 'first' : i == 1 ? 'second' : 'third';
    return Image.asset('assets/image/${name}3x.png',
      fit: BoxFit.contain,
    );
  }

  Widget rankText(int i){
    return Text('${i+1}',
      style: TextStyle(
        color: config.PrimaryColor,
        fontWeight: FontWeight.w500,
        fontSize: screen.setSp(36),
      ),
      overflow: TextOverflow.visible,
      maxLines:1,
    );
  }

}