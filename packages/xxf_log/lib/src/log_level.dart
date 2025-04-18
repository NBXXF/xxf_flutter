/// 日志等级
enum LogLevel {
  verbose(2),
  debug(3),
  info(4),
  warn(5),
  error(6);

  final int value;
  const LogLevel(this.value);
}