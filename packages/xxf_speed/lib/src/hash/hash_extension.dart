import 'dart:convert' show Encoding;

import 'package:hashlib/hashlib.dart' show md5, sha256, sha512, xxh3code;

extension HashExtension on String {
  int toXXH3Hash([Encoding? encoding]) {
    return xxh3code(this, encoding);
  }

  String toMD5Hash([Encoding? encoding]) {
    return md5.string(this).toString();
  }

  String toSHA256Hash([Encoding? encoding]) {
    return sha256.string(this).toString();
  }

  String toSHA512Hash([Encoding? encoding]) {
    return sha512.string(this).toString();
  }
}
