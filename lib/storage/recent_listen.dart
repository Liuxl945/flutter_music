import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> recentData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('recent') ?? [];
  return data;
}

// 添加搜索历史
insertRecent(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('recent') ?? [];
  data.add(name);

  await prefs.setStringList('recent', data);
}

// 删除搜索历史
deleteRecent(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('recent') ?? [];
  data.remove(name);
  print(data);
  await prefs.setStringList('recent', data);
}
