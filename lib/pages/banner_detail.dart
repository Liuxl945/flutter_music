import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BannerDetail extends StatefulWidget {
  final String url;
  BannerDetail({Key key, this.url}) : super(key: key);
  _BannerDetailState createState() => _BannerDetailState();
}

class _BannerDetailState extends State<BannerDetail> {
  // final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    print('${widget.url}--------------------------------->');

    return SafeArea(
      child: WebviewScaffold(
        url: widget.url,
        withZoom:true,
        withLocalStorage:true,
        hidden: true,
      ),
    );
  }
}