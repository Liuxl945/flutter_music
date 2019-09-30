import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> iLikeData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('iLike') ?? '[]';
  return data;
}

// 添加搜索历史
insertILike(String item) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('iLike') ?? [];
  data.remove(item);
  data.add(item);
  await prefs.setStringList('iLike', data);
}

// 删除搜索历史
deleteILike(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('iLike') ?? [];
  data.remove(name);
  await prefs.setStringList('iLike', data);
}
