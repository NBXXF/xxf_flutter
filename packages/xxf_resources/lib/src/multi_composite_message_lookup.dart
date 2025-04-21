import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

///solve issue https://github.com/dart-lang/i18n/issues/798 if you are using     intl_translate and intl_util both.
///解决多模块,初始化的时候只能初始化第一个
/// 用法(尽可能早): initializeInternalMessageLookup(() => MultiCompositeMessageLookup());
class MultiCompositeMessageLookup extends CompositeMessageLookup {
  @override
  void addLocale(String localeName, Function findLocale) {
    final canonical = Intl.canonicalizedLocale(localeName);
    final newLocale = findLocale(canonical);
    if (newLocale != null) {
      final oldLocale = availableMessages[localeName];
      if (oldLocale != null && newLocale != oldLocale) {
        if (newLocale is! MessageLookupByLibrary) {
          throw Exception(
            'Merge locale messages failed, type ${newLocale.runtimeType} is not supported.',
          );
        }
        // solve issue https://github.com/dart-lang/i18n/issues/798 if you are using     intl_translate and intl_util both.
        if (oldLocale.messages is Map<String, Function> &&
            newLocale.messages is! Map<String, Function>) {
          final newMessages = newLocale.messages.map(
            (key, value) => MapEntry(key, value as Function),
          );
          oldLocale.messages.addAll(newMessages);
        } else {
          oldLocale.messages.addAll(newLocale.messages);
        }
        return;
      }
      super.addLocale(localeName, findLocale);
    }
  }
}
