import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/style_extensions/color_style_extension.dart';

extension BuildContextExtension on BuildContext {
  ColorStyleExtension get color =>
      Theme.of(this).extension<ColorStyleExtension>()!;
}
