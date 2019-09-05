
import 'package:flutter/material.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_music/route/route.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);

    return CommonNavigation(
      params: Routes.recommend,
      listChildren: listChildren(),
    );
  }
  Widget listChildren(){
    return ListView(
      children: <Widget>[
        swiperBanner(),
        Text('recommend',
          style: TextStyle(
            fontSize: screen.setSp(55),
          ),
        ),
      ],
    );
  }
  Widget swiperBanner() {
    final List photo = [
      "https://img01.hua.com/uploadpic/newpic/9010011.jpg_220x240.jpg",
      "https://img01.hua.com/uploadpic/newpic/9012345.jpg_220x240.jpg",
      "https://img01.hua.com/uploadpic/newpic/9012413.jpg_220x240.jpg"
    ];

    return Container(
      height: screen.setHeight(300),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Hero(
            tag: photo[index],
            child: FadeInImage.memoryNetwork(
              placeholder:kTransparentImage,
              image: photo[index],
              fit: BoxFit.cover,
            ),
          );
        },
        onTap: (index){
          print(index);
        },

        loop: true,
        autoplay: true,
        itemCount: photo.length,
        pagination: SwiperPagination(),
      ),
    );
  }

}