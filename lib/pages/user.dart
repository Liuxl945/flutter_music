import 'package:flutter/material.dart';
import 'package:flutter_music/plugin/fit.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Text('userPage',
              style: TextStyle(
                fontSize: screen.setSp(55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}