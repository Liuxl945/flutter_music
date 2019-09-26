
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/provide/singer.dart';
import 'package:flutter_music/provide/song.dart';
import 'package:flutter_music/route/application.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/storage/search_history.dart' as storage;
import 'package:flutter_music/utils/song.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:flutter_music/variable.dart' as config;
import 'package:provide/provide.dart';


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchName;
  String searchKey = '';

  var _getHotKey;

  List searchData = [];
  bool searchNow = false; //是否是在搜索
  int page = 1; //当前搜索的页数
  final int perpage = 20; //每次搜索多少页

  @override
  void initState() {
    super.initState();
    _searchName = TextEditingController();

    _searchName.addListener(() async{
      final res = await MusicApi.getSearch(_searchName.text,page,true,perpage);
      Map data;
      try{
        data = json.decode(res.toString());
      }catch(e){
        data = json.decode(json.encode(res));
      }

      final List newData = _genResult(data['data']);
      setState(() {
        searchData = newData;
        searchKey = _searchName.text;
        searchNow = _searchName.text != '';
      });
    });
    _getHotKey = MusicApi.getHotKey();
  }

  @override
  void dispose() { 
    _searchName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.search,
      listChildren: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          searchBar(),
          Expanded(
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: searchNow,
                  child: hotSearch(),
                ),
                Offstage(
                  offstage: !searchNow,
                  child: searchList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List _normalizeSongs(list){
    final ret = [];
    list.forEach((item){
      if(item['songid'] != null && item['albummid'] != null){
        ret.add(
          CreateSong.createSong(item)
        );
      }
    });
    return ret;
  }

  List _genResult(Map data){
    final ret = [];
    if(data['zhida']['singerid'] != null){
      ret.add(data['zhida']);
    }
    
    if(data['song']['list'].length > 0){
      ret.addAll(_normalizeSongs(data['song']['list']));
    }
    return ret;
  }

  // 搜索框
  Widget searchBar(){
    return Container(
      margin: EdgeInsets.all(screen.setWidth(40)),
      padding: EdgeInsets.symmetric(vertical: screen.setWidth(18),horizontal: screen.setWidth(10)),
      decoration: BoxDecoration(
        color: config.BaseLightColor,
        borderRadius: BorderRadius.all(Radius.circular(screen.setWidth(12))),
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.search,color: config.LightFontColor),
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _searchName,
              style: TextStyle(fontSize: 18,color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: '请输入搜索内容',
                hintStyle:TextStyle(
                  color: config.LightFontColor,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(width: 0,style: BorderStyle.none),
                )
              ),
            ),
          ),
          Offstage(
            offstage: searchKey.length == 0,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  searchKey = '';
                  searchNow = false;
                  searchData = [];
                  if(_searchName != null) _searchName.clear();
                });
              },
              child: Icon(Icons.close,size: 20,color: config.LightFontColor),
            ),
          ),
        ],
      ),
    );
  }
  
  // 热门搜索关键词-搜索历史滑动列表
  Widget hotSearch(){
    return FutureBuilder(
      future: _getHotKey,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          List<Map> hotkeyList = (data['data']['hotkey'] as List).cast();
          return ListView(
            children: <Widget>[
              hotkeyTitle(),
              hotkeyContainer(hotkeyList),
              SizedBox(height: screen.setWidth(20)),
              Offstage(
                offstage: false,
                child: searchHistory(),
              ),
            ],
          );
        }else{
          return Container(
            child: Center(child: Text('暂时没有列表数据')),
          );
        }
      },
    );
  }

  Widget hotkeyTitle(){
    return Container(
      padding: EdgeInsets.only(bottom: screen.setWidth(40),left: screen.setWidth(40),right: screen.setWidth(40)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('热门搜索',
          style: TextStyle(
            color: config.PrimaryFontColor,
            fontSize: screen.setSp(28),
          ),
        ),
      ),
    );
  }

  // 搜索热门词
  Widget hotkeyContainer(hotkeyList){

    List<Widget> hotList = [];
    final int number = hotkeyList.length > 10 ? 10 : hotkeyList.length;
    for(var index = 0;index < number;index++){
      hotList.add(
        serchBtn(hotkeyList[index])
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal:  screen.setWidth(40)),
      child: Wrap(
        direction: Axis.horizontal,
        children: hotList,
      ),
    );
  }

  Widget serchBtn(item){
    return GestureDetector(
      onTap: (){
        setState(() {
          searchNow = true;
          _searchName.text = searchKey = item['k'].substring(0,item['k'].length-1);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screen.setWidth(20),vertical: screen.setWidth(10)),
        height: screen.setWidth(48),
        margin: EdgeInsets.only(right: screen.setWidth(30),bottom: screen.setWidth(30)),
        decoration: BoxDecoration(
          color: config.BaseLightColor,
          borderRadius: BorderRadius.all(Radius.circular(screen.setWidth(10))),
        ),
        child: Text(item['k'],
          style: TextStyle(
            color: config.LightFontColor,
          ),
        ),
      ),
    );
    
    
  }

  // 搜索历史
  Widget searchHistory(){
    Future<List<String>> history = storage.historyData();

    return FutureBuilder(
      future: history,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          List data = json.decode(json.encode(snapshot.data)) ?? [];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: screen.setWidth(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Offstage(
                  child: historyTitle(),
                  offstage: data.length == 0,
                ),
                historyList(data),
              ],
            ),
          );
        }else{
          return Container();
        }
        
      },
    );

    
  }

  Widget historyTitle(){
    return Container(
      padding: EdgeInsets.only(bottom: screen.setWidth(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('搜索历史',
              style: TextStyle(
                color: config.PrimaryFontColor,
                fontSize: screen.setSp(28),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              storage.clearSearchHistory();
              setState(() {});
            },
            child: Icon(Icons.delete,color: config.PrimaryFontColor),
          ),
        ],
      ),
    );
  }

  Widget historyList(List data){
    List<Widget> list = [];
    data.forEach((value){
      list.add(
        historyItem(value)
      );
    });
    return Column(
      children: list,
    );
  }

  Widget historyItem(name){
    return Container(
      padding: EdgeInsets.symmetric(vertical: screen.setWidth(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){
                _searchName.text = name;
              },
              child: Text(name,
                style: TextStyle(
                  color: config.PrimaryFontColor,
                  fontSize: screen.setSp(32),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              storage.deleteSearchName(name);
              setState(() {});
            },
            child: Icon(Icons.close,color: config.PrimaryFontColor),
          )
        ],
      ),
    );
  }


  // 搜索列表
  Widget searchList(){
    return Container(
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (BuildContext context, int index) {
          return searchItem(searchData[index]);
        },
      ),
    );
  }

  // 歌手信息数据
  Map<String,dynamic> singer(Map detals){
    return {
      'id':detals['singermid'],
      'name':detals['singername'],
      'avatar':'https://y.gtimg.cn/music/photo_new/T001R150x150M000${detals['singermid']}.jpg?max_age=2592000',
    };
  }

  // 单个搜索详情
  Widget searchItem(Map item){
    return GestureDetector(
      onTap: () async{
        
        if(item['singerid'] != null){

          Provide.value<Singer>(context).setSinger(singer(item));

          Application.router.navigateTo(context, '${Routes.singerDetail}?id=${item['singermid']}',transition: TransitionType.fadeIn);
        }else{
          storage.insertHistory(_searchName.text);

          if(item['id'] != Provide.value<SongState>(context).selectPlaying['id']){
            Provide.value<SongState>(context).addPlay(item);
            await Provide.value<SongState>(context).reloadPlay();
          }

          Application.router.navigateTo(context, Routes.disc,transition: TransitionType.fadeIn);
        }
        
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: screen.setWidth(20),horizontal: screen.setWidth(40)),
        child: Row(
          children: <Widget>[
            Container(
              width: screen.setWidth(32),
              height: screen.setWidth(32),
              child: Icon(item['type'] != null ? Icons.perm_identity : Icons.music_note ,color: config.PrimaryFontColor,size: screen.setSp(30)),
              margin: EdgeInsets.only(right: screen.setWidth(32)),
            ),
            Expanded(
              child: Text(item['type'] != null ? item['singername']: '${item['album']} ${item['singer']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: config.PrimaryFontColor,
                  fontSize: screen.setSp(28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
