import 'package:flutter/material.dart';

class SongState with ChangeNotifier{
  String lyric = '';

  setLyric(String value){
    lyric = value;
  }
}