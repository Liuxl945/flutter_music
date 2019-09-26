import 'package:flutter/material.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:provide/provide.dart';



// 歌曲CD旋转
class RotateAvatar extends StatefulWidget {
  RotateAvatar({Key key}) : super(key: key);

  _RotateAvatarState createState() => _RotateAvatarState();
}

class _RotateAvatarState extends State<RotateAvatar> with TickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(seconds: 10),
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
    );

    controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.repeat();
      }else if (status == AnimationStatus.dismissed){
        // controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<SongState>(builder: (context, child, counter){

      if(counter.playerState != PlayerState.playing){
        controller.stop();
      }else{
        controller.forward();
      }

      return RotationTransition(
        child: ClipOval(
          child: Image.network(counter.playlist.length > 0 ? counter.playlist[counter.currentIndex]['image'] : 'http://y.gtimg.cn/music/photo_new/T002R300x300M000000MkMni19ClKG.jpg?max_age=2592000',
            fit: BoxFit.cover,
          ),
        ),
        turns: controller,
      );
    });
  }
}