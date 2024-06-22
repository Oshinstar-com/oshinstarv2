import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashPattern;

  DottedBorder({
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashPattern = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashPattern: dashPattern,
      ),
      child: child,
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashPattern;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final dashWidth = dashPattern;
    final dashSpace = dashPattern;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final pathSegment = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(pathSegment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}