import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/constants/app_colors.dart';
import 'package:kanban_flutter/core/theme/style_extensions/text_style_extension.dart';

class TextStyles {
  static const lightTextStyle = TextStyleExtension(
    largeTitle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
    ),
  );
}
