

main(List<String> args) {
  final aa = {}.toString();
  final bb = DateTime.now().microsecondsSinceEpoch;
  print(aa == '{}');
  print(bb);
}