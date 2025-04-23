import 'package:bot_toast/bot_toast.dart';

typedef CancelFunction = void Function();

///https://mmmzq.github.io/bot_toast/#/
///https://pub.dev/packages/bot_toast
///https://github.com/MMMzq/bot_toast/blob/master/API_zh.md
///包装bot_toast 方便替换,业务不要直接使用bot_toast
class ToastUtils {
  ToastUtils._();

  static CancelFunction showToast(String text) {
    return BotToast.showText(text: text);
  }

  static CancelFunction showLoading() {
    return BotToast.showLoading();
  }
}
