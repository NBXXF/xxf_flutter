import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:xxf_log/src/log_method_type.dart';
import 'package:xxf_log/src/log_utils.dart';

class OutPutUtils {
  OutPutUtils._();

  ///正式环境下面的打印方式
  static void releaseOut(dynamic message) {
    LogMethodType methodType = LogUtils.config.releaseOutMethodType;
    switch (methodType) {
      case LogMethodType.debugPrint:
        {
          debugPrint(message);
        }
        break;
      case LogMethodType.print:
        {
          print(message);
        }
        break;
      case LogMethodType.stderr:
        {
          stderr.writeln(message);
        }
        break;
    }
  }
}
