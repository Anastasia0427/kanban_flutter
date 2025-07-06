import 'package:flutter/material.dart';

class ColorStyleExtension extends ThemeExtension<ColorStyleExtension> {
  final Color? primaryBackground;
  final Color? secondaryBackground;
  final Color? tertiaryBackground;

  final Color? backgroundElements;

  final Color? textFieldBackground;
  final Color? textFieldHint;

  final Color? primaryText;
  final Color? invertedPrimaryText;

  final Color? buttonPrimaryBackground;

  final Color? deleteColor;

  final Color? shadowColor;

  final Color? inactiveIconButton;

  final List<Color?>? boardPickerColors;

  final Color? defaultToDo;
  final Color? defaultInProgress;
  final Color? defaultDone;

  const ColorStyleExtension({
    this.primaryBackground,
    this.secondaryBackground,
    this.tertiaryBackground,
    this.backgroundElements,
    this.textFieldBackground,
    this.textFieldHint,
    this.primaryText,
    this.invertedPrimaryText,
    this.buttonPrimaryBackground,
    this.deleteColor,
    this.shadowColor,
    this.inactiveIconButton,
    this.boardPickerColors = const [],
    this.defaultToDo,
    this.defaultInProgress,
    this.defaultDone,
  });

  @override
  ColorStyleExtension copyWith({
    Color? primaryBackground,
    Color? secondaryBackground,
    Color? tertiaryBackground,
    Color? backgroundElements,
    Color? textFieldBackground,
    Color? textFieldHint,
    Color? primaryText,
    Color? invertedPrimaryText,
    Color? buttonPrimaryBackground,
    Color? deleteColor,
    Color? shadowColor,
    Color? inactiveIconButton,
    List<Color>? boardPickerColors,
    Color? defaultToDo,
    Color? defaultInProgress,
    Color? defaultDone,
  }) {
    return ColorStyleExtension(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      tertiaryBackground: tertiaryBackground ?? this.tertiaryBackground,
      backgroundElements: backgroundElements ?? this.backgroundElements,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      textFieldHint: textFieldHint ?? this.textFieldHint,
      primaryText: primaryText ?? this.primaryText,
      invertedPrimaryText: invertedPrimaryText ?? this.invertedPrimaryText,
      buttonPrimaryBackground:
          buttonPrimaryBackground ?? this.buttonPrimaryBackground,
      deleteColor: deleteColor ?? this.deleteColor,
      shadowColor: shadowColor ?? this.shadowColor,
      inactiveIconButton: inactiveIconButton ?? this.inactiveIconButton,
      boardPickerColors: boardPickerColors ?? this.boardPickerColors,
      defaultToDo: defaultToDo ?? this.defaultToDo,
      defaultInProgress: defaultInProgress ?? this.defaultInProgress,
      defaultDone: defaultDone ?? this.defaultDone,
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
      tertiaryBackground: Color.lerp(
        tertiaryBackground,
        other?.tertiaryBackground,
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
      deleteColor: Color.lerp(deleteColor, other?.deleteColor, t),
      shadowColor: Color.lerp(shadowColor, other?.shadowColor, t),
      inactiveIconButton: Color.lerp(
        inactiveIconButton,
        other?.inactiveIconButton,
        t,
      ),
      boardPickerColors: List<Color?>.generate(boardPickerColors?.length ?? 0, (
        index,
      ) {
        return Color.lerp(
          boardPickerColors?[index],
          other?.boardPickerColors?[index],
          t,
        );
      }),
      defaultToDo: Color.lerp(defaultToDo, other?.defaultToDo, t),
      defaultInProgress: Color.lerp(
        defaultInProgress,
        other?.defaultInProgress,
        t,
      ),
      defaultDone: Color.lerp(defaultDone, other?.defaultDone, t),
    );
  }
}
