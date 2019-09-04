import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/router.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:flutter_music/path.dart' as Path;

class Header extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screen.setHeight(88),
          color: config.BaseColor,
          child: logoImage(),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap:(){
              route.to(context, Path.User, {});
            },
            child: Container(
              height: screen.setHeight(88),
              width: screen.setWidth(88),
              child: Icon(
                Icons.perm_identity,
                size: screen.setHeight(44),
                color: config.PrimaryColor,
              ),
            ),
          ),
        ),        
      ],
    );
  }

  Widget logoImage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/image/logo3x.png',
          width: screen.setWidth(60),
          height: screen.setHeight(64),
        ),
        SizedBox(width: screen.setHeight(10)),
        Text(
          'Chicken Music',
          style: TextStyle(
            color: config.PrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: screen.setSp(36),
          ),
        ),
      ],
    );
  }

}