
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_music/api/api.dart';
import 'package:flutter_music/plugin/fit.dart';
import 'package:flutter_music/route/route.dart';
import 'package:flutter_music/widgets/common/common_navigation.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_music/variable.dart' as config;

typedef void OnTouchCallback(int index);

class SingerPage extends StatefulWidget {
  SingerPage({Key key}) : super(key: key);

  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {

  ScrollController scrollController = new ScrollController();
  List<dynamic> singerData = [];
  final hotName = "热门";
  final hotSingerLength = 20; //热门歌手长度
  int defaultIndex = 0;
  final double suspensionHeight = screen.setHeight(60);
  final double itemHeight = screen.setHeight(140);
  double opacity = 1; //IOS下下滑隐藏标题
  
  @override
  void initState() {
    scrollController.addListener((){
      double position = scrollController.offset.toDouble();
      final newOpacity = position <= 0 ? 0 : 1;
      
      int index = _computerIndex(position);
      
      if(index != defaultIndex){
        setState(() {
          defaultIndex = index;
        });
      }
      if(newOpacity != opacity){
        setState(() {
          opacity = newOpacity.toDouble();
        });
      }
    });
    MusicApi.getSingerList().then((val){
      var data = json.decode(val.toString());
      List<Map> singerList = (data['data']['list'] as List).cast();

      setState(() {
        singerData = _nomallizeSinger(singerList);
      });

    });
    super.initState();
  }

  @override
  void dispose() { 
    scrollController.dispose();
    super.dispose();
  }

  int _computerIndex(double position){
    if(singerData.length > 0){
      final index = defaultIndex > 1 ? defaultIndex- 1 : 0; //加载到后面的元素会循环很多次---优化后最多循环2次

      for (int i = index; i < singerData.length; i++) {
        double pre = _computerIndexPosition(i);
        double next = _computerIndexPosition(i + 1);
        if (position > pre && position < next) {
          return i;
        }
      }
    }
    return 0;
  }

  double _computerIndexPosition(int index){
    int n = 0;
    if(singerData.length > 0){
      for (int i = 0; i < index; i++) {
        n += (singerData[i]['items'].length).toInt();
      }
    }
    return n * itemHeight + (index) * (suspensionHeight + screen.setHeight(40));
  }


  List _nomallizeSinger(List list){
    Map map = {
      'hot':{
        'title':hotName,
        'items':[]
      }
    };

    for (var index = 0; index < list.length; index++) {
      final item = list[index];

      if(index < hotSingerLength){
        map['hot']['items'].add(
          singer({
            'id':item['Fsinger_mid'],
            'name':item['Fsinger_name'],
          })
        );
      }

      final key = item['Findex'];

      if(map[key] == null){
        map[key] = {
          'title':key,
          'items':[]
        };
      }

      map[key]['items'].add(
        singer({
          'id':item['Fsinger_mid'],
          'name':item['Fsinger_name'],
        })
      );
    }

    List ret = [];
    List hot = [];

    map.values.forEach((val){
      
      final title = val['title'];
      if(RegExp('[a-zA-Z]').hasMatch(title)){
        ret.add(val);
      }else if(val['title'] == hotName){
        hot.add(val);
      }
    });

    ret.sort((a, b){
      return a['title'].codeUnitAt(0) - b['title'].codeUnitAt(0);
    });
    
    return hot..addAll(ret);
  }

  // 歌手信息数据
  Map<String,dynamic> singer(Map detals){
    return {
      'id':detals['id'],
      'name':detals['name'],
      'avatar':'https://y.gtimg.cn/music/photo_new/T001R150x150M000${detals['id']}.jpg?max_age=2592000',
    };
  }

  void _onTouchCallback(int index){
    double position = _computerIndexPosition(index).clamp(.0, scrollController.position.maxScrollExtent);
    scrollController.jumpTo(position);
    setState((){
      defaultIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonNavigation(
      params: Routes.singer,
      listChildren: Stack(
        children: <Widget>[
          singerList(),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: screen.setWidth(40),
              alignment: Alignment.center,
              child: IndexBar(
                data:singerData,
                defaultIndex:defaultIndex,
                onTouchCallback:_onTouchCallback,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 歌手列表
  Widget singerList(){
    return Stack(
      children: <Widget>[

        ListView.builder(
          itemCount: singerData.length,
          itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              singerTitle(singerData[index]['title']),
              SizedBox(height: screen.setHeight(40)),
              singerListItem(singerData[index]['items']),
            ],
          );
         },
         controller:scrollController,
        ),

        Opacity(
          opacity: opacity,
          child: singerTitle(singerData.length > 0 ? singerData[defaultIndex]['title'] : hotName),
        )
        
      ],
    );
  }

  // A-B-C-D标题
  Widget singerTitle(name){
    return Container(
      width: screen.setWidth(750),
      height: screen.setHeight(60),
      color: config.BaseLightColor,
      padding: EdgeInsets.only(left: screen.setWidth(40)),
      alignment: Alignment.centerLeft,
      child: Text(name,
        style: TextStyle(
          color: config.PrimaryFontColor,
          fontSize: screen.setSp(24),
        ),
      ),
    );
  }

  Widget singerListItem(List<dynamic> items){
    List<Widget> list = [];
    items.forEach((item){
      list.add(
        singerItem(item)
      );
    });
    return Column(
      children: list,
    );
  }

  // 歌手单个样式
  Widget singerItem(singer){
    return Container(
      padding: EdgeInsets.only(left: screen.setWidth(60),bottom: screen.setHeight(40)),
      child: Row(
        children: <Widget>[
          singerAvatar(singer),
          Expanded(
            child: singerName(singer),
          ),
        ],
      ),
    );
  }

  // 歌手头像
  Widget singerAvatar(singer){
    return ClipOval(
      child: Container(
        child: FadeInImage.memoryNetwork(
          placeholder:kTransparentImage,
          image: singer['avatar'] ?? 'https://y.gtimg.cn/music/photo_new/T001R150x150M000002J4UUk29y8BY.jpg?max_age=2592000',
          fit: BoxFit.cover,
        ),
        height: screen.setHeight(100),
        width: screen.setWidth(100),
      ),
    );
  }

  // 歌手姓名
  Widget singerName(singer){
    return Container(
      padding: EdgeInsets.only(left: screen.setWidth(40)),
      child: Text(singer['name'],
        style: TextStyle(
          fontSize: screen.setSp(28),
          color: config.PrimaryFontColor,
        ),
      ),
    );
  }
}

class IndexBar extends StatefulWidget {
  final List<dynamic> data;
  final OnTouchCallback onTouchCallback;
  final defaultIndex;
  IndexBar({Key key,@required this.data, @required this.onTouchCallback, @required this.defaultIndex}) : super(key: key);

  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  List<Widget> children = [];
  void _createWidget(){
    children.clear();

    for (var i = 0; i < widget.data.length; i++) {
      final items = widget.data[i];
      children.add(
        barText('${items['title']}',i)
      );
    }
  }

  void _triggerTouch(int index) {
    if (widget.onTouchCallback != null) {
      widget.onTouchCallback(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    _createWidget();

    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details){
        int offset = details.globalPosition.dy.toInt();
        RenderBox rb = context.findRenderObject();
        int top = rb.localToGlobal(Offset.zero).dy.toInt();

        double offsetTop = offset - top - screen.setHeight(20);//减去上部padding的高度
        _triggerTouch((offsetTop / screen.setHeight(40)).floor());
      },
      onVerticalDragUpdate:(DragUpdateDetails details) {
        int offset = details.globalPosition.dy.toInt();
        RenderBox rb = context.findRenderObject();
        int top = rb.localToGlobal(Offset.zero).dy.toInt();
        double offsetTop = offset - top - screen.setHeight(20);//减去上部padding的高度
        int index = (offsetTop / screen.setHeight(40)).floor() <=0 ? 0: (offsetTop / screen.setHeight(40)).floor();
        _triggerTouch(index.clamp(.0, children.length - 1));
      },
      child: Container(
        width: screen.setWidth(40),
        padding: EdgeInsets.symmetric(vertical: screen.setHeight(20)),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, .3),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
  Widget barText(String name,int index){
    return Container(
      height: screen.setHeight(40),
      alignment: Alignment.center,
      child: Text(
        name.substring(0,1),
        style: TextStyle(
          color: index == widget.defaultIndex ? config.PrimaryColor : config.PrimaryFontColor,
          fontSize: screen.setSp(24),
        ),
      ),
    );
  }
}
