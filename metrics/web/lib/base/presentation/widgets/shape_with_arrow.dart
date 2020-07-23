import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

/// The widget that displays a shape with the arrow.
class ShapeWithArrow extends StatelessWidget {
  /// A width of the arrow.
  final double arrowWidth;

  /// A height of the arrow.
  final double arrowHeight;

  /// A side of the shape to display the arrow on.
  final BubblePosition bubblePosition;

  /// A background color of shape.
  final Color backgroundColor;

  /// A general padding around the [child].
  final EdgeInsets padding;

  final double arrowPadding;

  /// A child widget to be displayed.
  final Widget child;

  /// A percentage position of the arrow on [bubblePosition].
  final double arrowPositionPercent;

  /// A radius of the border of this shape.
  final double borderRadius;

  const ShapeWithArrow({
    Key key,
    this.arrowWidth,
    this.arrowHeight,
    this.bubblePosition,
    this.backgroundColor,
    this.padding,
    this.child,
    this.arrowPositionPercent,
    this.borderRadius,
    this.arrowPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyContext = (key as GlobalKey).currentContext;
    final size = (keyContext.findRenderObject() as RenderBox).size;
    print(size);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ShapeOfView(
          width: constraints.maxWidth,
          shape: BubbleShape(
            position: bubblePosition,
            arrowHeight: arrowHeight,
            arrowWidth: arrowWidth,
            arrowPositionPercent: 0.95,
            borderRadius: borderRadius,
          ),
          child: Container(
            padding: padding,
            color: backgroundColor,
            child: child,
          ),
        );
      },
    );
  }

  bool get isVertical =>
      bubblePosition == BubblePosition.Top ||
      bubblePosition == BubblePosition.Bottom;

  double calculateArrowPositionPercent(double width, double height) {
    if (isVertical) {
      return (width - arrowPadding - arrowWidth) / width;
    } else {
      return (height - arrowPadding - arrowHeight) / height;
    }
  }
}
