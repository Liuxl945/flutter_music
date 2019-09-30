import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/widgets/play/mini_play.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/widgets/play/play_btn_content.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 回退按钮
    Widget backArrow(){
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          width: screen.setWidth(80),
          height: screen.setWidth(80),
          child: Icon(Icons.arrow_back_ios,size: screen.setSp(44),color: config.PrimaryColor),
        ),
      );
    }

    Widget navTab(){
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Color.fromRGBO(51, 51, 51, 1)),
          borderRadius:BorderRadius.all(
            Radius.circular(screen.setWidth(10)),
          )
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: screen.setWidth(240),
              height: screen.setWidth(60),
              child: Text('我喜欢的',
                style: TextStyle(
                  color: config.LightFontColor,
                  fontSize: screen.setSp(28),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: screen.setWidth(240),
              height: screen.setWidth(60),
              color: Color.fromRGBO(51, 51, 51, 1),
              child: Text('最近听的',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen.setSp(28),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: screen.setWidth(10)),
            Row(
              children: <Widget>[
                backArrow(),
                SizedBox(width: screen.setWidth(55)),
                navTab(),
              ],
            ),
            
            SizedBox(height: screen.setWidth(40)),
            Container(
              height: screen.setWidth(64),
              child: PlayBtnContent(color: config.PrimaryFontColor), //随机播放全部
            ),
            SizedBox(height: screen.setWidth(10)),
            
            Expanded(
              child: ListView(
                children: <Widget>[
                  Text('11111111111'),
                ],
              ),
            ),
            MiniPlay(),
          ],
        ),
      ),
    );
  }
}