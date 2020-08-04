import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/base_popup.dart';
import 'package:metrics/common/presentation/widgets/metrics_popup.dart';

void main() {
  group("MetricsPopup", () {
    const testTriggerWidget = Text('trigger widget');
    const testChildWidget = Text('child widget');

    testWidgets(
      "throws an AssertionError if the given offset builder is null",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _MetricsPopupTestbed(offsetBuilder: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given child widget is null",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _MetricsPopupTestbed(child: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given trigger widget is null",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsPopupTestbed(triggerWidget: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the given trigger widget",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _MetricsPopupTestbed(triggerWidget: testTriggerWidget),
        );

        expect(find.byWidget(testTriggerWidget), findsOneWidget);
      },
    );

    testWidgets(
      "displays the given child when trigger widget is tapped",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _MetricsPopupTestbed(
            triggerWidget: testTriggerWidget,
            child: testChildWidget,
          ),
        );

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        expect(find.byWidget(testChildWidget), findsOneWidget);
      },
    );

    testWidgets(
      "applies the given offset builder to the composited transform follower widget",
      (WidgetTester tester) async {
        const testOffset = Offset(10.0, 10.0);

        await tester.pumpWidget(
          _MetricsPopupTestbed(
            triggerWidget: testTriggerWidget,
            offsetBuilder: (_) => testOffset,
          ),
        );

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        final follower = tester.widget<CompositedTransformFollower>(
          find.byType(CompositedTransformFollower),
        );
        final actualOffset = follower.offset;

        expect(actualOffset, equals(testOffset));
      },
    );

    testWidgets(
      "applies the given box constraints to the child widget",
      (WidgetTester tester) async {
        const boxConstraints = BoxConstraints(maxWidth: 50.0, maxHeight: 50.0);

        await tester.pumpWidget(
          const _MetricsPopupTestbed(
            triggerWidget: testTriggerWidget,
            boxConstraints: boxConstraints,
            child: testChildWidget,
          ),
        );

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        final constrainedBox = tester.widget<ConstrainedBox>(find.ancestor(
          of: find.byWidget(testChildWidget),
          matching: find.byType(ConstrainedBox),
        ));
        final actualBoxConstraints = constrainedBox.constraints;

        expect(actualBoxConstraints, equals(boxConstraints));
      },
    );
  });
}

Offset _defaultOffsetBuilder(Size size) => Offset.zero;

/// A testbed class required to test the [BasePopup] widget.
class _MetricsPopupTestbed extends StatelessWidget {
  /// The widget to trigger from.
  final Widget triggerWidget;

  /// The widget to display.
  final Widget child;

  /// The additional constraints to impose on the [child].
  final BoxConstraints boxConstraints;

  /// Used to build the [child] offset from the [triggerWidget].
  final OffsetBuilder offsetBuilder;

  /// Creates the [_MetricsPopupTestbed].
  ///
  /// The [triggerWidget] defaults to the [Icon] with the [Icons.group] icon data.
  /// The [child] defaults to the [SizedBox] with the empty constructor.
  /// The [boxConstraints] defaults to the [BoxConstraints]
  /// with the empty constructor.
  /// The [offsetBuilder] defaults to the [_defaultOffsetBuilder].
  const _MetricsPopupTestbed({
    Key key,
    this.triggerWidget = const Icon(Icons.group),
    this.child = const SizedBox(),
    this.boxConstraints = const BoxConstraints(),
    this.offsetBuilder = _defaultOffsetBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MetricsPopup(
          triggerWidget: triggerWidget,
          boxConstraints: boxConstraints,
          offsetBuilder: offsetBuilder,
          child: child,
        ),
      ),
    );
  }
}
