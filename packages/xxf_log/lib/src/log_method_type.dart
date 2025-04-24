///日志输出方式
///速度 [print] > [debugPrint] >stderr
enum LogMethodType {
  ///同步
  print(0),

  ///异步+长字符串拆分
  debugPrint(1),

  ///同步
  stderr(2);

  final int value;

  const LogMethodType(this.value);
}
