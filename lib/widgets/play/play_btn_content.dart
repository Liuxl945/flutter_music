import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;

class PlayBtnContent extends StatefulWidget {
  final Color color;
  PlayBtnContent({Key key , this.color = config.PrimaryColor}) : super(key: key);

  _PlayBtnContentState createState() => _PlayBtnContentState();
}

class _PlayBtnContentState extends State<PlayBtnContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen.setWidth(270),
      height: screen.setWidth(64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(200),
        ),
        border: Border.all(width: 1,color: widget.color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.play_circle_outline,
            color: widget.color,
          ),
          SizedBox(width: screen.setWidth(10)),
          Text('随机播放全部',
            style: TextStyle(
              color: widget.color,
              fontSize: screen.setSp(24),
            ),
          ),
        ],
      ),
    );
  }
}