import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/music/song_list.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/widgets/play/mini_play.dart';
import 'package:provide/provide.dart';

class MusicList extends StatefulWidget {
  final List songs;
  final String bgImage;
  final String title;
  final bool rank;

  MusicList({Key key,@required this.songs,@required this.bgImage,@required this.title,this.rank = false}) : super(key: key);

  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  ScrollController scrollController = ScrollController();
  double imageHeight = screen.setWidth(525);
  double appbarHeight = screen.setWidth(88);
  bool opacity = false; 
  
  
  @override
  void initState() {
    scrollController.addListener((){
      double position = scrollController.offset.toDouble();
      if(position >= imageHeight){
        if(!opacity){
          setState(() {
            opacity = true;
          });
        }
      }else{
        if(opacity){
          setState(() {
            opacity = false;
          });
        }
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screeHeight = MediaQuery.of(context).size.height; //屏幕高度
    final screeTop = MediaQuery.of(context).padding.top; //安全区域高度

    return Stack(
      children: <Widget>[
        Container(
          height: screeHeight - screeTop,
          child: mainBoby(),
        ),
        topAppbar(),
      ],
    );
  }

  Widget mainBoby(){
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            controller: scrollController,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  backgroundImage(),
                  background(),
                  playBtn(),
                ],
              ),
              SongList(songs:widget.songs,rank: widget.rank,),
            ],
          ),
        ),
        
        MiniPlay() //迷你播放器
      ],
    );
  }

  
  // 顶部appbar
  Widget topAppbar(){
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        color: opacity ? config.BaseColor : Colors.transparent,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: appbarHeight,
                child: Icon(Icons.arrow_back_ios,size: screen.setSp(44),color: config.PrimaryColor),
              ),
            ),
            Expanded(
              child:Container(
                alignment: Alignment.center,
                height: appbarHeight,
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screen.setSp(36),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: appbarHeight),
          ],
        ),
      )
    );
  }

  
  // 背景图片
  Widget backgroundImage(){
    return Image.network(widget.bgImage ?? 'http://p.qpic.cn/music_cover/6pKF7XnkTESE8L7nkkbjXmnLUPZbvSSs8cK05D8EGTLibpd8m4OGpBg/600?n=1',
      width: screen.setWidth(750),
      height: imageHeight,
      fit: BoxFit.cover,
    );
  }

  // 背景蒙版
  Widget background(){
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        width: screen.setWidth(750),
        height: imageHeight,
        color: Color.fromRGBO(7, 17, 27, .4),
      ),
    );
  }

  Widget playBtnContent(){
    return Container(
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
          Icon(
            Icons.play_circle_outline,
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
    );
  }

  // 随机播放按钮
  Widget playBtn(){
    return Positioned(
      top: screen.setWidth(421),
      left: screen.setWidth(240),
      child: GestureDetector(
        onTap: () async{
          
          Provide.value<SongState>(context).randomPlay(widget.songs);
          await Provide.value<SongState>(context).reloadPlay();

          Application.router.navigateTo(context, Routes.disc,transition: TransitionType.fadeIn);
        },
        child: playBtnContent(),
      ),
    );
  }

}