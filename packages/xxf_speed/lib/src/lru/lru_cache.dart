import 'lru_map.dart';

///lru 淘汰算法的cache
class LruCache<K, V> {
  final int capacity;
  final LruMap<K, V> _cache;

  LruCache(this.capacity)
    : assert(capacity > 0),
      _cache = LruMap<K, V>(maximumSize: capacity);

  /// 获取缓存内容（若不存在返回 null）
  V? get(K key) => _cache[key];

  /// 设置缓存（若超出容量会自动淘汰最旧的项）
  void set(K key, V value) {
    _cache[key] = value;
  }

  /// 判断是否存在
  bool contains(K key) => _cache.containsKey(key);

  /// 删除某个键
  void remove(K key) {
    _cache.remove(key);
  }

  /// 清空缓存
  void clear() {
    _cache.clear();
  }

  /// 当前缓存键集合
  Iterable<K> get keys => _cache.keys;

  /// 当前缓存值集合
  Iterable<V> get values => _cache.values;

  /// 当前大小
  int get length => _cache.length;

  /// 是否为空
  bool get isEmpty => _cache.isEmpty;

  /// 是否已满（注意：未必准确，因为 LruMap 会自动驱逐旧项）
  bool get isFull => _cache.length >= capacity;

  @override
  String toString() => _cache.toString();
}
