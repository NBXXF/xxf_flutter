extension IterableExtensions<E> on Iterable<E> {
  ///reduce() 假定至少有一个元素,如果没有元素时，reduce() 会抛出异常
  E reduceWithInitialValue(
    E initialValue,
    E Function(E previousValue, E element) combine,
  ) {
    return fold(initialValue, combine);
  }
}
