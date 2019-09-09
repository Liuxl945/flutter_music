import 'package:flutter/material.dart';

class Singer with ChangeNotifier{
  Map singer = {};

  setSinger(value){
    singer = value;
    notifyListeners();
  }
}