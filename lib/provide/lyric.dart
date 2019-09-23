import 'package:flutter/material.dart';

class LyricState with ChangeNotifier{
  String lyric = '';

  setLyric(String value){
    lyric = value;
  }
}