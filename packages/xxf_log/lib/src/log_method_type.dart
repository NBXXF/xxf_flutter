///日志输出方式
enum LogMethodType {
  ///异步+长字符串拆分
  debugPrint(0),
  ///同步
  print(1),
  ///同步
  stderr(2);

  final int value;

  const LogMethodType(this.value);
}
