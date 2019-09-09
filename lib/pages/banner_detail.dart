import 'package:flutter/material.dart';
import 'package:flutter_music/provide/banner_url.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provide/provide.dart';

class BannerDetail extends StatefulWidget {
  
  BannerDetail({Key key}) : super(key: key);
  _BannerDetailState createState() => _BannerDetailState();
}

class _BannerDetailState extends State<BannerDetail> {
  // final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    
    final url = Provide.value<BannerUrl>(context).url;

    return SafeArea(
      child: WebviewScaffold(
        url: url,
        withZoom:true,
        withLocalStorage:true,
        hidden: true,
      ),
    );
  }
}