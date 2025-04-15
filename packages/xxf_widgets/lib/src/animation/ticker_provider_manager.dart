import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';

///管理时钟
class TickerProviderManager extends TickerProvider {
  Set<Ticker>? _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <Ticker>{};
    Ticker ticker = Ticker(onTick);
    _tickers?.add(ticker);
    return ticker;
  }

  void dispose() {
    if (_tickers != null) {
      for (final Ticker ticker in _tickers!) {
        ticker.dispose();
      }
      _tickers?.clear();
    }
  }
}
