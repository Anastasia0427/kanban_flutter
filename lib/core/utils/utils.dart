import 'dart:ui';

import 'package:intl/intl.dart';

class Utils {
  static bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  static Color stringToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  static String colorToStringWithAlpha(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static final dateDBFormat = DateFormat('yyyy-MM-dd');
  static final dateFormat = DateFormat('dd.MM.yyyy');
}
