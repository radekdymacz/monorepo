import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/base_popup.dart';

void main() {
  group('BasePopup', () {
    const testTriggerWidget = Text('trigger widget');
    const testChildWidget = Text('child widget');

    testWidgets(
      "throws an AssertionError if the given trigger widget is null",
      (tester) async {
        await tester.pumpWidget(const _BasePopupTestbed(triggerWidget: null));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given child widget is null",
      (tester) async {
        await tester.pumpWidget(const _BasePopupTestbed(child: null));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given offset builder is null",
      (tester) async {
        await tester.pumpWidget(const _BasePopupTestbed(offsetBuilder: null));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given transition builder is null",
      (tester) async {
        await tester.pumpWidget(
          const _BasePopupTestbed(transitionBuilder: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the given transition duration is null",
      (tester) async {
        await tester.pumpWidget(
          const _BasePopupTestbed(transitionDuration: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the given trigger widget",
      (tester) async {
        await tester.pumpWidget(
          const _BasePopupTestbed(triggerWidget: testTriggerWidget),
        );

        expect(find.byWidget(testTriggerWidget), findsOneWidget);
      },
    );
    testWidgets(
      "displays the given child when the trigger widget is tapped",
      (tester) async {
        await tester.pumpWidget(const _BasePopupTestbed(
          triggerWidget: testTriggerWidget,
          child: testChildWidget,
        ));

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        expect(find.byWidget(testChildWidget), findsOneWidget);
      },
    );

    testWidgets(
      "applies the given offset builder to the composited transform follower widget",
      (tester) async {
        const offset = Offset(20.0, 20.0);

        await tester.pumpWidget(_BasePopupTestbed(
          triggerWidget: testTriggerWidget,
          offsetBuilder: (_) => offset,
        ));

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        final followerWidget = tester.widget<CompositedTransformFollower>(
          find.byType(CompositedTransformFollower),
        );

        expect(followerWidget.offset, equals(offset));
      },
    );

    testWidgets(
      "applies the given box constraints to the child widget",
      (WidgetTester tester) async {
        const boxConstraints = BoxConstraints(maxWidth: 50.0, maxHeight: 50.0);

        await tester.pumpWidget(
          const _BasePopupTestbed(
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

    testWidgets(
      "applies the default box constraints to the child widget if null is passed",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _BasePopupTestbed(
            triggerWidget: testTriggerWidget,
            boxConstraints: null,
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

        expect(actualBoxConstraints, isNotNull);
      },
    );

    testWidgets(
      "applies the given transition builder when trigger widget is tapped",
      (tester) async {
        const transitionTestWidget = Text('transition widget');

        await tester.pumpWidget(_BasePopupTestbed(
          triggerWidget: testTriggerWidget,
          transitionBuilder: (_, __, ___, ____) => transitionTestWidget,
        ));

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        expect(find.byWidget(transitionTestWidget), findsOneWidget);
      },
    );

    testWidgets(
      "closes a base popup with the given child after tap outside of the popup",
      (tester) async {
        const defaultSize = 20.0;

        await tester.pumpWidget(const _BasePopupTestbed(
          triggerWidget: testTriggerWidget,
          boxConstraints: BoxConstraints(maxHeight: defaultSize),
          child: testChildWidget,
        ));

        await tester.tap(find.byWidget(testTriggerWidget));
        await tester.pumpAndSettle();

        expect(find.byWidget(testChildWidget), findsOneWidget);

        await tester.tapAt(const Offset(defaultSize, defaultSize));
        await tester.pumpAndSettle();

        expect(find.byWidget(testChildWidget), findsNothing);
      },
    );
  });
}

/// Builds the default offset.
Offset _defaultOffsetBuilder(Size size) => Offset.zero;

/// Builds the default transition.
Widget _defaultRouteTransitionBuilder(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) =>
    child;

/// A testbed class required to test the [BasePopup] widget.
class _BasePopupTestbed extends StatelessWidget {
  /// The widget to trigger from.
  final Widget triggerWidget;

  /// The widget to display.
  final Widget child;

  /// The additional constraints to impose on the [child].
  final BoxConstraints boxConstraints;

  /// Used to build the [child] offset from the [triggerWidget].
  final OffsetBuilder offsetBuilder;

  /// Used to build the route's transitions.
  final RouteTransitionsBuilder transitionBuilder;

  /// The duration the transition going forwards.
  final Duration transitionDuration;

  /// Creates the [BasePopup].
  ///
  /// The [triggerWidget] defaults to the [Icon] with the [Icons.group] icon data.
  /// The [child] defaults to the [SizedBox] with the empty constructor.
  /// The [boxConstraints] defaults to the [BoxConstraints]
  /// with the empty constructor.
  /// The [offsetBuilder] defaults to the [_defaultOffsetBuilder].
  /// The [transitionBuilder] defaults to the [_defaultRouteTransitionBuilder].
  /// The [transitionDuration] defaults to the `1 second`.
  const _BasePopupTestbed({
    Key key,
    this.triggerWidget = const Icon(Icons.group),
    this.child = const SizedBox(),
    this.boxConstraints = const BoxConstraints(),
    this.offsetBuilder = _defaultOffsetBuilder,
    this.transitionBuilder = _defaultRouteTransitionBuilder,
    this.transitionDuration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BasePopup(
          triggerWidget: triggerWidget,
          boxConstraints: boxConstraints,
          offsetBuilder: offsetBuilder,
          transitionBuilder: transitionBuilder,
          transitionDuration: transitionDuration,
          child: child,
        ),
      ),
    );
  }
}
