import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/decoration/arrow_shape_border.dart';

void main() {
  group("ArrowShapeBorder", () {
    const arrowPosition = ArrowPosition.top;
    const arrowAlignment = ArrowAlignment.start;
    const mockDouble = 28.0;

    testWidgets(
      "applies the given arrow position to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          position: arrowPosition,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.position, arrowPosition);
      },
    );

    testWidgets(
      "applies the given arrow alignment to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          alignment: arrowAlignment,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.alignment, arrowAlignment);
      },
    );

    testWidgets(
      "applies the given arrow height to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          arrowHeight: mockDouble,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.arrowHeight, mockDouble);
      },
    );

    testWidgets(
      "applies the given arrow width to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          arrowWidth: mockDouble,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.arrowWidth, mockDouble);
      },
    );

    testWidgets(
      "applies the given arrow offset to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          offset: mockDouble,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.offset, mockDouble);
      },
    );

    testWidgets(
      "applies the given border radius to the shape",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ArrowShapeBorderTestbed(
          borderRadius: mockDouble,
        ));

        final cardWidget = tester.widget<Card>(find.byType(Card));
        final shape = cardWidget.shape as ArrowShapeBorder;

        expect(shape.borderRadius, mockDouble);
      },
    );
  });
}

/// A testbed widget, used to test the [ArrowShapeBorder] shape border.
class _ArrowShapeBorderTestbed extends StatelessWidget {
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

  /// A radius of the border of the shape.
  final double borderRadius;

  /// Creates the [_ArrowShapeBorderTestbed] with the given attributes.
  ///
  /// The [position] defaults to [ArrowPosition.bottom].
  /// The [borderRadius] defaults to `12.0`.
  /// The [arrowHeight] defaults to `10.0`.
  /// The [arrowWidth] defaults to `10.0`.
  /// The [offset] defaults to `0.0`.
  /// The [alignment] defaults to [ArrowAlignment.center].
  const _ArrowShapeBorderTestbed({
    Key key,
    this.position = ArrowPosition.bottom,
    this.alignment = ArrowAlignment.center,
    this.borderRadius = 12.0,
    this.arrowHeight = 10.0,
    this.arrowWidth = 10.0,
    this.offset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: Card(
            shape: ArrowShapeBorder(
              borderRadius: borderRadius,
              arrowWidth: arrowWidth,
              arrowHeight: arrowHeight,
              alignment: alignment,
              position: position,
              offset: offset,
            ),
          ),
        ),
      ),
    );
  }
}
