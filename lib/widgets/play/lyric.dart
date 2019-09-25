import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/lyric.dart';
import 'package:provide/provide.dart';

class Lyric extends StatefulWidget {
  Lyric({Key key}) : super(key: key);

  _LyricState createState() => _LyricState();
}

class _LyricState extends State<Lyric> {
  Timer _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<LyricState>(builder: (context, child, counter){
      
      return Container(
        padding: EdgeInsets.only(bottom: screen.setHeight(20)),
        child: ListView.builder(
          itemCount: counter.lyric.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: screen.setHeight(10)),
              child: Text(counter.lyric[index]['txt'],
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, index == counter.curLine ? 1 : .5),
                  fontSize: screen.setSp(28),
                ),
              ),
            );
          },
        ),
      );
    }); 
  }
}

