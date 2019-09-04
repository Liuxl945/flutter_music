
import 'package:flutter_music/api/config.dart' as config;
import 'package:dio/dio.dart';
const API_URL = 'localhost:8000';

Dio dio = new Dio(); 

class MusicApi {
  static getRecomend() async{
    print('开始获取数据------------------->');
    final url = 'https://c.y.qq.com/musichall/fcgi-bin/fcg_yqqhomepagerecommend.fcg';

    final Map<String,dynamic> queryParameters = {
      'platform': 'h5',
      'uin': 0,
      'needNewCode': 1,
    };
    queryParameters.addAll(config.commonParams);
    
    Response response = await dio.get(url,queryParameters:queryParameters);

    print(response.data);
    return response.data;
  }
}