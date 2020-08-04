import 'dart:math';
import 'package:flutter/material.dart';

/// Enum that represents the side of the shape to display the arrow on.
enum ArrowPosition { bottom, top, left, right }

/// Enum that represents the alignment of the arrow.
enum ArrowAlignment { start, center, end }

/// A shape border with the arrow.
class ArrowShapeBorder extends ShapeBorder {
  /// A side of the shape to display the arrow on.
  final ArrowPosition position;

  /// An alignment of the arrow.
  final ArrowAlignment alignment;

  /// A height of the arrow.
  final double arrowHeight;

  /// A width of the arrow.
  final double arrowWidth;

  /// An offset of the arrow.
  /// Sets the shift horizontally or vertically depending on the [position].
  /// Can be a negative.
  final double offset;

  /// A radius of the border of this shape.
  final double borderRadius;

  /// Creates the [ArrowShapeBorder].
  const ArrowShapeBorder({
    this.alignment = ArrowAlignment.center,
    this.position = ArrowPosition.bottom,
    this.borderRadius = 12.0,
    this.arrowHeight = 10.0,
    this.arrowWidth = 10.0,
    this.offset = 0.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  /// Defines whether this arrow on the vertical axis.
  bool get _isVertical =>
      position == ArrowPosition.top || position == ArrowPosition.bottom;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final path = Path();

    final topLeftDiameter = max(borderRadius, 0);
    final topRightDiameter = max(borderRadius, 0);
    final bottomLeftDiameter = max(borderRadius, 0);
    final bottomRightDiameter = max(borderRadius, 0);

    final spacingLeft = position == ArrowPosition.left ? arrowWidth : 0.0;
    final spacingTop = position == ArrowPosition.top ? arrowHeight : 0.0;
    final spacingRight = position == ArrowPosition.right ? arrowWidth : 0.0;
    final spacingBottom = position == ArrowPosition.bottom ? arrowHeight : 0.0;

    final double left = spacingLeft + rect.left;
    final double top = spacingTop + rect.top;
    final double right = rect.right - spacingRight;
    final double bottom = rect.bottom - spacingBottom;

    final arrowPositionPercent = _getArrowPositionPercent(rect.size);
    final double centerX = (rect.left + rect.right) * arrowPositionPercent;
    final double centerY = (rect.bottom - rect.top) * arrowPositionPercent;

    path.moveTo(left + topLeftDiameter / 2.0, top);

    if (position == ArrowPosition.top) {
      path.lineTo(centerX - arrowWidth + offset, top);
      path.lineTo(centerX + offset, rect.top);
      path.lineTo(centerX + arrowWidth + offset, top);
    }
    path.lineTo(right - topRightDiameter / 2.0, top);

    path.quadraticBezierTo(right, top, right, top + topRightDiameter / 2);

    if (position == ArrowPosition.right) {
      path.lineTo(right, centerY - arrowHeight + offset);
      path.lineTo(rect.right, centerY + offset);
      path.lineTo(right, centerY + arrowHeight + offset);
    }
    path.lineTo(right, bottom - bottomRightDiameter / 2);

    path.quadraticBezierTo(
        right, bottom, right - bottomRightDiameter / 2, bottom);

    if (position == ArrowPosition.bottom) {
      path.lineTo(centerX + arrowWidth + offset, bottom);
      path.lineTo(centerX + offset, rect.bottom);
      path.lineTo(centerX - arrowWidth + offset, bottom);
    }
    path.lineTo(left + bottomLeftDiameter / 2, bottom);

    path.quadraticBezierTo(left, bottom, left, bottom - bottomLeftDiameter / 2);

    if (position == ArrowPosition.left) {
      path.lineTo(left, centerY - arrowHeight + offset);
      path.lineTo(rect.left, centerY + offset);
      path.lineTo(left, centerY + arrowHeight + offset);
    }
    path.lineTo(left, top + topLeftDiameter / 2);

    path.quadraticBezierTo(left, top, left + topLeftDiameter / 2, top);

    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  /// Calculates the relative position of the arrow.
  double _getArrowPositionPercent(Size size) {
    final width = size.width;
    final height = size.height;

    switch (alignment) {
      case ArrowAlignment.start:
        return _isVertical ? arrowWidth / width : arrowHeight / height;
      case ArrowAlignment.center:
        return 0.5;
      case ArrowAlignment.end:
        return _isVertical
            ? (width - arrowWidth) / width
            : (height - arrowHeight) / height;
      default:
        return 0.5;
    }
  }
}
