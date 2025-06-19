import 'package:kanban_flutter/core/theme/constants/app_colors.dart';
import 'package:kanban_flutter/core/theme/style_extensions/color_style_extension.dart';

class ColorStyles {
  static const lightColorStyle = ColorStyleExtension(
    primaryBackground: LightAppColors.primaryBackground,
    secondaryBackground: LightAppColors.secondaryBackground,
    backgroundElements: LightAppColors.backgroundElements,
    textFieldBackground: LightAppColors.textFieldBackground,
    textFieldHint: LightAppColors.textFieldHint,
    primaryText: LightAppColors.primaryText,
    invertedPrimaryText: LightAppColors.invertedPrimaryText,
    buttonPrimaryBackground: LightAppColors.buttonPrimaryBackground,
  );
}
