///测量运行时间
Duration measureTime(void Function() block) {
  final sw = Stopwatch()..start();
  block();
  sw.stop();
  return sw.elapsed;
}

///纳秒
int measureTimeNanos(void Function() block) {
  return measureTime(block).inMicroseconds * 1000;
}

///微秒
int measureTimeMicros(void Function() block) {
  return measureTime(block).inMicroseconds;
}

///毫秒
int measureTimeMillis(void Function() block) {
  return measureTime(block).inMilliseconds;
}
