import 'package:flutter/material.dart';

class BannerUrl with ChangeNotifier{
  String url = 'https://yingliyingli.com';

  setUrl(value){
    url = value;
    notifyListeners();
  }
}