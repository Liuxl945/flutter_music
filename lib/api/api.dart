
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

  static Future getSearch(query, page, zhida, perpage) async{
    final url = 'https://c.y.qq.com/soso/fcgi-bin/search_for_qq_cp';
    Options options = Options(headers: {
      'referer': 'https://m.y.qq.com/?ADTAG=myqq',
      'origin': 'https://m.y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'w': query,
      'p': page,
      'perpage':perpage,
      'n': perpage,
      'catZhida': zhida ? 1 : 0,
      'zhidaqu': 1,
      't': 0,
      'flag': 1,
      'ie': 'utf-8',
      'sem': 1,
      'aggr': 0,
      'remoteplace': 'txt.mqq.all',
      'uin': 0,
      'needNewCode': 1,
      'platform': 'h5'
    };
    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;
  }

  static Future getMusicResult(songmid) async{
    final url = 'https://c.y.qq.com/soso/fcgi-bin/search_for_qq_cp';
    Options options = Options(headers: {
      'referer': 'https://y.qq.com/portal/player.html',
      'origin': 'https://y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'hostUin': 0,
      'loginUin': 0,
      'needNewCode': 0,
      'platform': 'yqq.json',
      'data':'{"req":{"module":"CDN.SrfCdnDispatchServer","method":"GetCdnDispatch","param":{"guid":"1416627489","calltype":0,"userip":""}},"req_0":{"module":"vkey.GetVkeyServer","method":"CgiGetVkey","param":{"guid":"1416627489","songmid":["$songmid"],"songtype":[0],"uin":"0","loginflag":1,"platform":"20"}},"comm":{"uin":0,"format":"json","ct":24,"cv":0}}'
    };

    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;
  }

  static Future getLyric(songmid) async{
    final url = 'https://c.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_new.fcg';
    Options options = Options(headers: {
      'referer': 'https://y.qq.com/portal/player.html',
      'origin': 'https://y.qq.com'
    });

    final Map<String,dynamic> queryParameters = {
      'songmid': songmid,
      'pcachetime': DateTime.now().microsecondsSinceEpoch,
      'platform': "yqq.json",
      'needNewCode': 0,
      'loginUin': 0,
      'hostUin': 0,
      "-": "MusicJsonCallback_lrc"
    };

    queryParameters.addAll(config.commonParams);
    Response response = await dio.get(url,queryParameters:queryParameters,options: options);
    return response.data;
  }


}
