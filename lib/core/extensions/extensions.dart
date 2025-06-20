import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/style_extensions/color_style_extension.dart';
import 'package:kanban_flutter/core/theme/style_extensions/text_style_extension.dart';
import 'package:kanban_flutter/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  ColorStyleExtension get color =>
      Theme.of(this).extension<ColorStyleExtension>()!;
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  TextStyleExtension get text =>
      Theme.of(this).extension<TextStyleExtension>()!;
}
