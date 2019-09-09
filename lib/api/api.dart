
import 'dart:math';
import 'package:flutter_music/api/config.dart' as config;
import 'package:dio/dio.dart';


const API_URL = 'localhost:8000';

Dio dio = new Dio(); 

class MusicApi {
  static Future getRecomend() async{
    final url = 'https://c.y.qq.com/musichall/fcgi-bin/fcg_yqqhomepagerecommend.fcg';

    final Map<String,dynamic> queryParameters = {
      'platform': 'h5',
      'uin': 0,
      'needNewCode': 1,
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters);
    return response.data;
  }

  static Future getDiscList() async{
    final url = 'https://c.y.qq.com/splcloud/fcgi-bin/fcg_get_diss_by_tag.fcg';

    Options options = Options(headers: {
      'referer': 'https://y.qq.com/portal/playlist.html',
      'origin': 'https://y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'platform': 'yqq.json',
      'hostUin': 0,
      'picmid': 1,
      'rnd': Random(),
      'loginUin': 0,
      'hostUin': 0,
      'needNewCode': 0,
      'categoryId': 10000000,
      'sortId': 5,
      'sin': 0,
      'ein': 29
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;
  }

  static Future getTopList() async{
    final url = 'https://c.y.qq.com/v8/fcg-bin/fcg_myqq_toplist.fcg';

    Options options = Options(headers: {
      'referer': 'https://m.y.qq.com/',
      'origin': 'https://y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'platform': 'h5',
      'uin': 0,
      'needNewCode': 1,
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;
  }

  static Future getHotKey() async{
    final url = 'https://c.y.qq.com/splcloud/fcgi-bin/gethotkey.fcg';

    final Map<String,dynamic> queryParameters = {
      'platform': 'h5',
      'uin': 0,
      'needNewCode': 1,
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters);
    return response.data;
  }

  static Future getSingerList() async{
    final url = 'https://c.y.qq.com/v8/fcg-bin/v8.fcg';

    final Map<String,dynamic> queryParameters = {
      'channel': 'singer',
      'page': 'list',
      'key': 'all_all_all',
      'pagesize': 100,
      'pagenum': 1,
      'hostUin': 0,
      'needNewCode': 0,
      'platform': 'yqq'
    };

    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters);
    return response.data;
  }

  static Future getDisstList(disstid) async{
    final url = 'https://c.y.qq.com/qzone/fcg-bin/fcg_ucc_getcdinfo_byids_cp.fcg';
    Options options = Options(headers: {
      'referer': 'https://y.qq.com/n/yqq/playlist',
      'origin': 'https://y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'disstid':disstid,
      'type': 1,
      'json': 1,
      'utf8': 1,
      'onlysong': 0,
      'platform': 'yqq.json',
      'loginUin': 0,
      'hostUin': 0,
      'needNewCode': 0
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;

  }

  static Future getSingerDetail(singerId) async{
    final url = 'https://c.y.qq.com/v8/fcg-bin/fcg_v8_singer_track_cp.fcg';
    final Map<String,dynamic> queryParameters = {
      'loginUin': 0,
      'format': 'json',
      'platform': 'yqq.json',
      'needNewCode': 0,
      'order': 'listen',
      'begin': 0,
      'num': 100,
      'songstatus': 1,
      'singermid': singerId
    };

    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters);
    return response.data;
  }

  static Future getMusicList(topid) async{
    final url = 'https://c.y.qq.com/v8/fcg-bin/fcg_v8_toplist_cp.fcg';
    final Map<String,dynamic> queryParameters = {
      'topid':topid,
      'needNewCode': 1,
      'uin': 0,
      'tpl': 3,
      'page': 'detail',
      'type': 'top',
      'platform': 'h5'
    };

    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters);
    return response.data;
  }


}