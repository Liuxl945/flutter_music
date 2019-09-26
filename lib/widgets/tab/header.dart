import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/variable.dart' as config;

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 44,
          color: config.BaseColor,
          child: logoImage(),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap:(){
              Application.router.navigateTo(context, Routes.user,transition: TransitionType.fadeIn);
            },
            child: Container(
              height: screen.setWidth(88),
              width: screen.setWidth(88),
              child: Icon(
                Icons.perm_identity,
                size: screen.setWidth(44),
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
        // Image.asset(
        //   'assets/image/logo3x.png',
        //   width: screen.setWidth(60),
        //   height: screen.setWidth(64),
        // ),
        SizedBox(width: screen.setWidth(10)),
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