import 'package:flutter/material.dart';

class ColorStyleExtension extends ThemeExtension<ColorStyleExtension> {
  final Color? primaryBackground;
  final Color? secondaryBackground;

  final Color? backgroundElements;

  final Color? textFieldBackground;
  final Color? textFieldHint;

  final Color? primaryText;
  final Color? invertedPrimaryText;

  final Color? buttonPrimaryBackground;

  const ColorStyleExtension({
    this.primaryBackground,
    this.secondaryBackground,
    this.backgroundElements,
    this.textFieldBackground,
    this.textFieldHint,
    this.primaryText,
    this.invertedPrimaryText,
    this.buttonPrimaryBackground,
  });

  @override
  ColorStyleExtension copyWith({
    Color? primaryBackground,
    Color? secondaryBackground,
    Color? backgroundElements,
    Color? textFieldBackground,
    Color? textFieldHint,
    Color? primaryText,
    Color? invertedPrimaryText,
    Color? buttonPrimaryBackground,
  }) {
    return ColorStyleExtension(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      backgroundElements: backgroundElements ?? this.backgroundElements,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      textFieldHint: textFieldHint ?? this.textFieldHint,
      primaryText: primaryText ?? this.primaryText,
      invertedPrimaryText: invertedPrimaryText ?? this.invertedPrimaryText,
      buttonPrimaryBackground:
          buttonPrimaryBackground ?? this.buttonPrimaryBackground,
    );
  }

  @override
  ColorStyleExtension lerp(ColorStyleExtension? other, double t) {
    return ColorStyleExtension(
      primaryBackground: Color.lerp(
        primaryBackground,
        other?.primaryBackground,
        t,
      ),
      secondaryBackground: Color.lerp(
        secondaryBackground,
        other?.secondaryBackground,
        t,
      ),
      backgroundElements: Color.lerp(
        backgroundElements,
        other?.backgroundElements,
        t,
      ),
      textFieldBackground: Color.lerp(
        textFieldBackground,
        other?.textFieldBackground,
        t,
      ),
      textFieldHint: Color.lerp(textFieldHint, other?.textFieldHint, t),
      primaryText: Color.lerp(primaryText, other?.primaryText, t),
      invertedPrimaryText: Color.lerp(
        invertedPrimaryText,
        other?.invertedPrimaryText,
        t,
      ),
      buttonPrimaryBackground: Color.lerp(
        buttonPrimaryBackground,
        other?.buttonPrimaryBackground,
        t,
      ),
    );
  }
}
