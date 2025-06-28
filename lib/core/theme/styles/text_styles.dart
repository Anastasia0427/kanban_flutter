import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/constants/app_colors.dart';
import 'package:kanban_flutter/core/theme/style_extensions/text_style_extension.dart';

class TextStyles {
  static const lightTextStyle = TextStyleExtension(
    largeTitle: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
      decoration: TextDecoration.none,
    ),
    mediumTitle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
      decoration: TextDecoration.none,
    ),
    smallTitle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
      decoration: TextDecoration.none,
    ),
    buttonLabel: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
    ),
    invertedButtonLabel: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: LightAppColors.invertedPrimaryText,
    ),
    textFieldHint: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: LightAppColors.textFieldHint,
    ),
    textFieldInput: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
    ),
    textFieldError: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: LightAppColors.textFieldError,
    ),
    headerTitle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: LightAppColors.invertedPrimaryText,
    ),
    deleteButtonLabel: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: LightAppColors.deleteColor,
    ),
  );
}
