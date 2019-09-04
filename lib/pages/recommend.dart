
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/base.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

final recommendPage = () => BodyPage.formBuild((ctx, params, router){
  
  Widget swiperBanner() {
    final List photo = [
      "https://img01.hua.com/uploadpic/newpic/9010011.jpg_220x240.jpg",
      "https://img01.hua.com/uploadpic/newpic/9012345.jpg_220x240.jpg",
      "https://img01.hua.com/uploadpic/newpic/9012413.jpg_220x240.jpg"
    ];

    return Container(
      height: screen.setHeight(300),
      child: Theme(
        data: Theme.of(ctx).copyWith(primaryColor: config.PrimaryColor),
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
      ),
    );
  }

  return CommonNavigation(
    params: params,
    listChildren: ListView(
      children: <Widget>[
        swiperBanner(),
        Text('recommend',
          style: TextStyle(
            fontSize: screen.setSp(55),
          ),
        ),
      ],
    ),
  );
});
