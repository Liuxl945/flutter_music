import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;

class DiscPage extends StatefulWidget {
  DiscPage({Key key}) : super(key: key);

  _DiscPageState createState() => _DiscPageState();
}

class _DiscPageState extends State<DiscPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.network('http://y.gtimg.cn/music/photo_new/T002R300x300M000000MkMni19ClKG.jpg?max_age=2592000',
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              width: screen.setWidth(750),
              fit: BoxFit.fill,
              ),
            ),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.black.withOpacity(.5),
                )
              ),
            ),
            
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: screen.setWidth(80),
                          height: screen.setHeight(80),
                          child: Icon(Icons.expand_more,size: screen.setSp(64),color: config.PrimaryColor),
                        ),
                      ),
                      Expanded(
                        child: Text('琥珀列车琥琥珀列车',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            
                            color: Colors.white,
                            fontSize: screen.setSp(36),
                          ),
                        ),
                      ),
                      SizedBox(width: screen.setHeight(80)),
                    ],
                  ),
                ),
                Container(
                  child: Text('瓦洛与琥珀虫',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screen.setSp(28),
                    ),
                  ),
                ),
                SizedBox(height: screen.setHeight(50)),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: screen.setHeight(600),
                        width: screen.setWidth(600),
                        padding: EdgeInsets.all(screen.setWidth(20)),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, .2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(300),
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network('http://y.gtimg.cn/music/photo_new/T002R300x300M000000MkMni19ClKG.jpg?max_age=2592000',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screen.setHeight(60)),
                        child: Container(
                          width: screen.setWidth(600),
                          child: Text('曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦曲：周杰伦',
                            style: TextStyle(
                              color: config.PrimaryFontColor,
                              fontSize: screen.setSp(28),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screen.setHeight(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screen.setWidth(40),
                        height: screen.setHeight(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color.fromRGBO(255, 255, 255, .8),
                        ),
                      ),
                      SizedBox(width: screen.setWidth(20)),
                      Container(
                        width: screen.setWidth(16),
                        height: screen.setHeight(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color.fromRGBO(255, 255, 255, .5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screen.setHeight(100),
                  width: screen.setWidth(600),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: screen.setWidth(60),
                        child: Text('0:00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screen.setSp(24),
                          ),
                        ),
                      ),
                      Container(
                        width: screen.setWidth(480),
                        height: screen.setHeight(8),
                        decoration: BoxDecoration(
                        color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      Container(
                        width: screen.setWidth(60),
                        alignment: Alignment.centerRight,
                        child: Text('0:00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screen.setSp(24),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screen.setHeight(80),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.copyright,
                            color: config.PrimaryColor,
                            size: screen.setSp(60),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.skip_previous,
                            color: config.PrimaryColor,
                            size: screen.setSp(60),
                          ),
                        ),
                      ),
                      Container(
                        width: screen.setWidth(214),
                        child: Container(
                          child: Icon(Icons.play_circle_outline,
                            color: config.PrimaryColor,
                            size: screen.setSp(80),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.skip_next,
                            color: config.PrimaryColor,
                            size: screen.setSp(60),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.favorite_border,
                            color: config.PrimaryColor,
                            size: screen.setSp(60),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screen.setHeight(100)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}