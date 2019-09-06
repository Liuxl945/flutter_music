
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:flutter_music/variable.dart' as config;


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController ctl;
  String searchKey = '';

  @override
  void initState() { 
    super.initState();
    ctl = TextEditingController();
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
            child: hotSearch(),
          ),
        ],
      ),
    );
  }

  // 搜索框
  Widget searchBar(){
    return Container(
      margin: EdgeInsets.all(screen.setHeight(40)),
      padding: EdgeInsets.symmetric(vertical: screen.setHeight(18),horizontal: screen.setHeight(10)),
      decoration: BoxDecoration(
        color: config.BaseLightColor,
        borderRadius: BorderRadius.all(Radius.circular(screen.setHeight(12))),
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.search,color: config.LightFontColor),
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: ctl,
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
              onChanged: (value){
                setState(() {
                  searchKey = value;
                });
              },
            ),
          ),
          Offstage(
            offstage: searchKey.length == 0,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  searchKey = '';
                  if(ctl != null) ctl.clear();
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
      future: MusicApi.getHotKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          var data = json.decode(snapshot.data.toString());
          List<Map> hotkeyList = (data['data']['hotkey'] as List).cast();
          print(hotkeyList);
          return ListView(
            children: <Widget>[
              hotkeyTitle(),
              hotkeyContainer(hotkeyList),
              SizedBox(height: screen.setHeight(20)),
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
      padding: EdgeInsets.only(bottom: screen.setHeight(40),left: screen.setHeight(40),right: screen.setHeight(40)),
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
      margin: EdgeInsets.symmetric(horizontal:  screen.setHeight(40)),
      child: Wrap(
        direction: Axis.horizontal,
        children: hotList,
      ),
    );
  }

  Widget serchBtn(item){
    return GestureDetector(
      onTap: (){
        print(item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screen.setWidth(20),vertical: screen.setHeight(10)),
        height: screen.setWidth(48),
        margin: EdgeInsets.only(right: screen.setWidth(30),bottom: screen.setWidth(30)),
        decoration: BoxDecoration(
          color: config.BaseLightColor,
          borderRadius: BorderRadius.all(Radius.circular(screen.setHeight(10))),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screen.setWidth(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          historyTitle(),
          historyList(),
        ],
      ),
    );
  }

  Widget historyTitle(){
    return Container(
      padding: EdgeInsets.only(bottom: screen.setHeight(20)),
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
              print('222');
            },
            child: Icon(Icons.delete,color: config.PrimaryFontColor),
          ),
        ],
      ),
    );
  }

  Widget historyList(){
    return Column(
      children: <Widget>[
        historyItem('那个女孩'),
        historyItem('恋人未满'),
        historyItem('大于'),
        historyItem('篮子回头'),
        historyItem('周杰昆仑'),
        historyItem('那个女孩'),
        historyItem('恋人未满'),
        historyItem('大于'),
        historyItem('篮子回头'),
        historyItem('周杰昆仑'),
        historyItem('那个女孩'),
        historyItem('恋人未满'),
        historyItem('大于'),
        historyItem('篮子回头'),
        historyItem('周杰昆仑'),
      ],
    );
  }

  Widget historyItem(name){
    return Container(
      padding: EdgeInsets.symmetric(vertical: screen.setHeight(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){
                print('111');
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
              print('222');
            },
            child: Icon(Icons.close,color: config.PrimaryFontColor),
          )
        ],
      ),
    );
  }

}
