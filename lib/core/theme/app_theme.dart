import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/styles/color_styles.dart';
import 'package:kanban_flutter/core/theme/styles/text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorStyles.lightColorStyle.primaryBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorStyles.lightColorStyle.primaryBackground,
    ),
    extensions: [ColorStyles.lightColorStyle, TextStyles.lightTextStyle],
  );
}
