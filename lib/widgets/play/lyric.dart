import 'package:flutter/material.dart';

class Lyric extends StatefulWidget {

  final lyric;

  Lyric({Key key,this.lyric}) : super(key: key);

  _LyricState createState() => _LyricState();
}

class _LyricState extends State<Lyric> {

  @override
  Widget build(BuildContext context) {

    final List lines = widget.lyric.split('\n');
    // print(widget.lyric);
    // print(lines);
    RegExp pattern = RegExp(r"\[\d{2}:\d{2}.\d{2,3}]");

    int _stamp2int(final String stamp) {
      final int indexOfColon = stamp.indexOf(":");
      final int indexOfPoint = stamp.indexOf(".");

      final int minute = int.parse(stamp.substring(1, indexOfColon));
      final int second = int.parse(stamp.substring(indexOfColon + 1, indexOfPoint));
      int millisecond;
      if (stamp.length - indexOfPoint == 2) {
        millisecond = int.parse(stamp.substring(indexOfPoint + 1, stamp.length)) * 10;
      } else {
        millisecond = int.parse(stamp.substring(indexOfPoint + 1, stamp.length - 1));
      }
      return ((((minute * 60) + second) * 1000) + millisecond);
    }

    List<Map> _formatLyric = [];//歌词

    for (var i = 0; i < lines.length; i++) {
      final String line = lines[i];
      var stamps = pattern.allMatches(line);
      var content = line.split(pattern).last;

      Map<int,String> map = {};
      bool isOk = false;
      if(stamps.toString() != '()'){
        isOk = true;
        stamps.forEach((stamp){
          int timeStamp = _stamp2int(stamp.group(0));
          map[timeStamp] = content;
          if(content == ''){
            isOk = false;
          }
        });
      }
      if(isOk){
        _formatLyric.add(map);
      }
      
    }
    print(_formatLyric);


    return Container(
      
    );
  }
}