import 'package:flutter/material.dart';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  final TextStyle? largeTitle;
  final TextStyle? mediumTitle;
  final TextStyle? smallTitle;

  final TextStyle? buttonLabel;
  final TextStyle? invertedButtonLabel;

  final TextStyle? textFieldHint;

  const TextStyleExtension({
    this.largeTitle,
    this.mediumTitle,
    this.smallTitle,
    this.buttonLabel,
    this.invertedButtonLabel,
    this.textFieldHint,
  });

  @override
  TextStyleExtension copyWith({
    TextStyle? largeTitle,
    TextStyle? mediumTitle,
    TextStyle? smallTitle,
    TextStyle? buttonLabel,
    TextStyle? invertedButtonLabel,
    TextStyle? textFieldHint,
  }) {
    return TextStyleExtension(
      largeTitle: largeTitle ?? this.largeTitle,
      mediumTitle: mediumTitle ?? this.mediumTitle,
      smallTitle: smallTitle ?? this.smallTitle,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      invertedButtonLabel: invertedButtonLabel ?? this.invertedButtonLabel,
      textFieldHint: textFieldHint ?? this.textFieldHint,
    );
  }

  @override
  TextStyleExtension lerp(TextStyleExtension? other, double t) {
    return TextStyleExtension(
      largeTitle: TextStyle.lerp(largeTitle, other?.largeTitle, t),
      mediumTitle: TextStyle.lerp(mediumTitle, other?.mediumTitle, t),
      smallTitle: TextStyle.lerp(smallTitle, other?.smallTitle, t),
      buttonLabel: TextStyle.lerp(buttonLabel, other?.buttonLabel, t),
      invertedButtonLabel: TextStyle.lerp(
        invertedButtonLabel,
        other?.invertedButtonLabel,
        t,
      ),
      textFieldHint: TextStyle.lerp(textFieldHint, other?.textFieldHint, t),
    );
  }
}
