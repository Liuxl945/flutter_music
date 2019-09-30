import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> historyData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('searchHistory') ?? [];
  return data;
}

// 添加搜索历史
insertHistory(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('searchHistory') ?? [];
  data.remove(name);
  data.add(name);
  await prefs.setStringList('searchHistory', data);
}

// 删除搜索历史
deleteSearchName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('searchHistory') ?? [];
  data.remove(name);
  await prefs.setStringList('searchHistory', data);
}

clearSearchHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('searchHistory', []);
}