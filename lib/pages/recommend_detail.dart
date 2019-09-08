import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;


class RecommendDetail extends StatefulWidget {
  final id;
  RecommendDetail({Key key,this.id}) : super(key: key);

  _RecommendDetailState createState() => _RecommendDetailState();
}

class _RecommendDetailState extends State<RecommendDetail> {
  ScrollController scrollController = ScrollController();
  double imageHeight = screen.setHeight(525);
  double appbarHeight = screen.setHeight(88);

  @override
  void initState() {
    scrollController.addListener((){
      double position = scrollController.offset.toDouble();
      
      print(position);
    });
    super.initState();
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
          child: Stack(
            children: <Widget>[
              Container(
                height: screeHeight - screeTop,
                child: ListView(
                  controller: scrollController,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.network('http://p.qpic.cn/music_cover/6pKF7XnkTESE8L7nkkbjXmnLUPZbvSSs8cK05D8EGTLibpd8m4OGpBg/600?n=1',
                          width: screen.setWidth(750),
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            width: screen.setWidth(750),
                            height: imageHeight,
                            color: Color.fromRGBO(7, 17, 27, .4),
                          ),
                        ),
                        
                        // 随机播放按钮
                        Positioned(
                          top: screen.setHeight(421),
                          left: screen.setWidth(240),
                          child: Container(
                            width: screen.setWidth(270),
                            height: screen.setWidth(64),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(200),
                              ),
                              border: Border.all(width: 1,color: config.PrimaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.play_circle_outline,
                                  color: config.PrimaryColor,
                                ),
                                SizedBox(width: screen.setWidth(10)),
                                Text('随机播放全部',
                                  style: TextStyle(
                                    color: config.PrimaryColor,
                                    fontSize: screen.setSp(24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Column(
                      children: listViewChildren(),
                    )
                  ],
                ),
              ),

              // 顶部appbar
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: appbarHeight,
                      child: Icon(Icons.arrow_back_ios,size: 36,color: config.PrimaryColor),
                    ),
                    Expanded(
                      child:Container(
                        alignment: Alignment.center,
                        height: appbarHeight,
                        child: Text('词牌曲 | 以才情作词，以意境为歌',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: screen.setSp(36),
                            color: Colors.white,
                          ),
                        ),
                      )
                    ),
                    SizedBox(width: appbarHeight),
                  ],
                  
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  

  List<Widget> listViewChildren(){
    List<Widget> list = [];

    for (var i = 0; i < 20; i++) {
      list.add(
        Container(
          height: screen.setHeight(88),
          child: Text('dsdsadsada',style: TextStyle(color: Colors.white)),
        )
      );
    }
    return list;
  }
}
