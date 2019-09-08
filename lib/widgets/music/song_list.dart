import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;

class SongList extends StatefulWidget {
  final List songs;

  SongList({Key key,@required this.songs}) : super(key: key);

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

    for (var i = 0; i < item.length; i++) {
      list.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: screen.setWidth(60)),
          alignment: Alignment.centerLeft,
          height: screen.setHeight(128),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item[i]['name'],style: TextStyle(color: Colors.white,fontSize: screen.setSp(28))),
              SizedBox(height: screen.setHeight(20)),
              Text('${item[i]['singer']}.${item[i]['album']}',style: TextStyle(color: config.PrimaryFontColor,fontSize: screen.setSp(28))),
            ],
          ),
        )
      );
    }
    return list;
  }
}