import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanban_flutter/core/theme/constants/app_colors.dart';

class PatternPainter extends CustomPainter {
  final List<Shape> shapes;

  const PatternPainter(this.shapes);

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = LightAppColors.backgroundElements
      ..style = PaintingStyle.fill;

    final spiralPaint = Paint()
      ..color = LightAppColors.backgroundElements
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (var shape in shapes) {
      switch (shape.type) {
        case ShapeType.circle:
          canvas.drawCircle(shape.center, shape.radius, circlePaint);
          break;
        case ShapeType.spiral:
          canvas.save();
          canvas.translate(shape.center.dx, shape.center.dy);
          canvas.rotate(shape.rotation);
          _drawSpiral(canvas, Offset.zero, shape.radius, spiralPaint);
          canvas.restore();
          break;
      }
    }
  }

  void _drawSpiral(
    Canvas canvas,
    Offset center,
    double maxRadius,
    Paint paint,
  ) {
    const double turns = 4;
    final path = Path();

    for (double t = 0; t < pi * 2 * turns; t += 0.1) {
      final r = (t / (pi * 2 * turns)) * maxRadius;
      final x = center.dx + r * cos(t);
      final y = center.dy + r * sin(t);

      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  static List<Shape> generateShapes(Size size, int count) {
    final random = Random();
    final shapes = <Shape>[];

    int attempts = 0;
    while (shapes.length < count && attempts < count * 10) {
      final radius = random.nextDouble() * 20 + 40;
      final x = random.nextDouble() * (size.width - radius * 2) + radius;
      final y = random.nextDouble() * (size.height - radius * 2) + radius;
      final type = random.nextBool() ? ShapeType.circle : ShapeType.spiral;
      final rotation = random.nextDouble() * 2 * pi;

      final newShape = Shape(
        type: type,
        center: Offset(x, y),
        radius: radius,
        rotation: rotation,
      );

      final intersects = shapes.any(
        (s) =>
            (s.center - newShape.center).distance <
            (s.radius + newShape.radius + 10),
      );

      if (!intersects) {
        shapes.add(newShape);
      }

      attempts++;
    }

    return shapes;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum ShapeType { circle, spiral }

class Shape {
  final ShapeType type;
  final Offset center;
  final double radius;
  final double rotation;

  Shape({
    required this.type,
    required this.center,
    required this.radius,
    required this.rotation,
  });
}
