import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> historyData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> history = prefs.getStringList('searchHistory') ?? [];
  return history;
}

// 添加搜索历史
insertHistory(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> history = prefs.getStringList('searchHistory') ?? [];
  history.add(name);

  await prefs.setStringList('searchHistory', history);
}

// 删除搜索历史
deleteSearchName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> history = prefs.getStringList('searchHistory') ?? [];
  history.remove(name);
  print(history);
  await prefs.setStringList('searchHistory', history);
}

clearSearchHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('searchHistory', []);
}