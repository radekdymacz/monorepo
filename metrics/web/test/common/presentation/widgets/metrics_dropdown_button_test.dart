import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/widgets/metrics_dropdown_button.dart';

void main() {
  group("MetricsDropdownButton", () {
    const items = [
      DropdownMenuItem(key: Key('key1'), value: 1, child: Text('1')),
      DropdownMenuItem(key: Key('key2'), value: 2, child: Text('2')),
      DropdownMenuItem(key: Key('key3'), value: 3, child: Text('3')),
    ];

    testWidgets("displays a dropdown button", (tester) async {
      await tester.pumpWidget(const _MetricsDropdownButtonTestbed());

      expect(find.byType(DropdownButton), findsOneWidget);
    });

    testWidgets("sets the given padding", (tester) async {
      const padding = EdgeInsets.all(5.0);

      await tester.pumpWidget(
        const _MetricsDropdownButtonTestbed(padding: padding),
      );

      final widget = tester.widget<MetricsDropdownButton>(
        find.byType(MetricsDropdownButton),
      );

      expect(widget.padding, equals(padding));
    });

    testWidgets("sets the given items", (tester) async {
      await tester.pumpWidget(const _MetricsDropdownButtonTestbed(
        items: items,
      ));

      final widget = tester.widget<MetricsDropdownButton>(
        find.byType(MetricsDropdownButton),
      );

      expect(widget.items, equals(items));
    });

    testWidgets("sets the given value", (tester) async {
      const value = 1;
      await tester.pumpWidget(const _MetricsDropdownButtonTestbed<int>(
        value: 1,
      ));

      final widget = tester.widget<MetricsDropdownButton>(
        find.byType(MetricsDropdownButton),
      );

      expect(widget.value, equals(value));
    });

    testWidgets("callback is called on tap on menu item", (tester) async {
      bool isCalled = false;

      await tester.pumpWidget(
        _MetricsDropdownButtonTestbed<int>(
          items: items,
          onChanged: (_) {
            isCalled = true;
          },
        ),
      );

      await tester.tap(find.byType(MetricsDropdownButton));
      await tester.pump();

      await tester.tap(
        find.descendant(
          of: find.byType(DropdownButton),
          matching: find.byKey(const Key('key1')),
        ),
      );

      expect(isCalled, isTrue);
    });

    testWidgets("shows disabled hint if onChange callback is null",
        (tester) async {
      const disabledHint = 'test disabled';

      await tester.pumpWidget(
        const _MetricsDropdownButtonTestbed<int>(
          disabledHint: Text(disabledHint),
          onChanged: null,
        ),
      );

      expect(find.text(disabledHint), findsOneWidget);
    });
  });
}

/// A testbed widget, used to test the [MetricsTextPlaceholder] widget.
class _MetricsDropdownButtonTestbed<T> extends StatelessWidget {
  final EdgeInsets padding;
  final List<DropdownMenuItem> items;
  final T value;
  final ValueChanged onChanged;
  final Widget disabledHint;

  const _MetricsDropdownButtonTestbed({
    Key key,
    this.padding,
    this.items,
    this.value,
    this.onChanged,
    this.disabledHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MetricsDropdownButton(
          padding: padding,
          items: items,
          value: value,
          onChanged: onChanged,
          disabledHint: disabledHint,
        ),
      ),
    );
  }
}
