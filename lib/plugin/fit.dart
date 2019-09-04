import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fit {
  var getInstance;
  Fit(){
    getInstance = ScreenUtil.getInstance();
  }

  setWidth(double number){
    return getInstance.setWidth(number);
  }
  setHeight(double number){
    return getInstance.setHeight(number);
  }
  setSp(double number){
    return getInstance.setSp(number);
  }
}

Fit screen = Fit();
