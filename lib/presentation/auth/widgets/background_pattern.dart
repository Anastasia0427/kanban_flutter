import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/extensions/extensions.dart';
import 'package:kanban_flutter/core/utils/pattern_painter.dart';

class BackgroundPattern extends StatefulWidget {
  const BackgroundPattern({super.key});

  @override
  State<BackgroundPattern> createState() => _BackgroundPatternState();
}

class _BackgroundPatternState extends State<BackgroundPattern> {
  late final List<Shape> shapes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size =
        View.of(context).physicalSize / View.of(context).devicePixelRatio;
    shapes = PatternPainter.generateShapes(size, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.primaryBackground,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: PatternPainter(shapes),
      ),
    );
  }
}
