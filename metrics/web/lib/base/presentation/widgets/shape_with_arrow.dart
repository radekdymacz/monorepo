import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class ShapeWithArrow extends StatelessWidget {
  final double arrowWidth;

  final double arrowHeight;

  final BubblePosition bubblePosition;

  final Color backgroundColor;

  final EdgeInsets padding;

  final Widget child;

  final double arrowPositionPercent;

  final double borderRadius;

  final double width;

  const ShapeWithArrow({
    Key key,
    this.arrowWidth,
    this.arrowHeight,
    this.bubblePosition,
    this.backgroundColor,
    this.padding,
    this.child,
    this.arrowPositionPercent,
    this.borderRadius, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShapeOfView(
      width: width,
      shape: BubbleShape(
        position: bubblePosition,
        arrowHeight: arrowHeight,
        arrowWidth: arrowWidth,
        arrowPositionPercent: arrowPositionPercent,
        borderRadius: borderRadius,
      ),
      child: Container(
        padding: padding,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
