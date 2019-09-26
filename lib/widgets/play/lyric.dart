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

  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() { 
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Provide<LyricState>(builder: (context, child, counter){
      
      final double lineHeight = screen.setWidth(56);
      int minInt = 6;
      if(counter.curLine > minInt){
        final double value = lineHeight* (counter.curLine - minInt);
        // print(value);
        Timer(Duration(milliseconds: 10),(){
          scrollController.jumpTo(value);
        });
      }
      

      return Container(
        padding: EdgeInsets.only(bottom: screen.setWidth(20)),
        child: ListView.builder(
          controller: scrollController,
          itemCount: counter.lyric.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: screen.setWidth(56),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: screen.setWidth(10)),
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

