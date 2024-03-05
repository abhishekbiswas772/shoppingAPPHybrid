import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAuthScreenDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final heightOffset = height * 0.13;

    Path path = Path();
    path.lineTo(0, height - heightOffset);
    path.cubicTo(
      width * 0.15, height, // First control point
      width * 0.35, height - heightOffset, // Second control point
      width * 0.5, height - heightOffset, // End point
    );
    path.cubicTo(
      width * 0.65, height - heightOffset, // Third control point
      width * 0.85, height, // Fourth control point
      width, height - heightOffset, // End point
    );
    path.lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
