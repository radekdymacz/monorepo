import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/dropdown_menu.dart';
import 'package:metrics/common/presentation/dropdown/widgets/metrics_dropdown_body.dart';
import 'package:metrics/common/presentation/dropdown/widgets/metrics_dropdown_menu.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/dropdown/theme/theme_data/dropdown_theme_data.dart';

import '../../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("MetricsDropdownMenu", () {
    const items = ['1', '2'];

    final metricsDropdownMenuFinder = find.byWidgetPredicate(
      (widget) => widget is MetricsDropdownMenu,
    );

    final mouseRegionFinder = find.descendant(
      of: metricsDropdownMenuFinder,
      matching: find.byType(MouseRegion).last,
    );

    Future<void> openDropdownMenu(WidgetTester tester) async {
      await tester.tap(metricsDropdownMenuFinder);
      await tester.pumpAndSettle();
    }

    BoxDecoration findBoxDecoration(WidgetTester tester) {
      final container = tester.widget<Container>(
        find.descendant(
          of: metricsDropdownMenuFinder,
          matching: find.byType(Container),
        ),
      );

      return container.decoration as BoxDecoration;
    }

    const closedButtonBackgroundColor = Colors.red;
    const openedButtonBackgroundColor = Colors.yellow;
    const hoverBackgroundColor = Colors.green;
    const closedButtonBorderColor = Colors.grey;
    const openedButtonBorderColor = Colors.black;
    const hoverBorderColor = Colors.indigo;

    const theme = MetricsThemeData(
      dropdownTheme: DropdownThemeData(
        closedButtonBackgroundColor: closedButtonBackgroundColor,
        openedButtonBackgroundColor: openedButtonBackgroundColor,
        hoverBackgroundColor: hoverBackgroundColor,
        closedButtonBorderColor: closedButtonBorderColor,
        openedButtonBorderColor: openedButtonBorderColor,
        hoverBorderColor: hoverBorderColor,
      ),
    );

    testWidgets(
      "throws an AssertionError if the item builder parameter is null",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(itemBuilder: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "throws an AssertionError if the selected item parameter is null",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(selectedItemBuilder: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "applies the closed button background color from metrics theme if closed",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        final decoration = findBoxDecoration(tester);

        expect(decoration.color, equals(closedButtonBackgroundColor));
      },
    );

    testWidgets(
      "applies the opened button background color from the metrics theme if open",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        await openDropdownMenu(tester);

        final decoration = findBoxDecoration(tester);

        expect(decoration.color, equals(openedButtonBackgroundColor));
      },
    );

    testWidgets(
      "applies the hover background color from the metrics theme if hovered",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder);
        const pointerExitEvent = PointerEnterEvent();
        mouseRegion.onEnter(pointerExitEvent);

        await tester.pump();

        final decoration = findBoxDecoration(tester);

        expect(decoration.color, equals(hoverBackgroundColor));
      },
    );

    testWidgets(
      "applies the closed button border color from the metrics theme if closed",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        final decoration = findBoxDecoration(tester);
        final boxBorder = decoration.border as Border;

        expect(boxBorder.top.color, equals(closedButtonBorderColor));
        expect(boxBorder.bottom.color, equals(closedButtonBorderColor));
        expect(boxBorder.right.color, equals(closedButtonBorderColor));
        expect(boxBorder.left.color, equals(closedButtonBorderColor));
      },
    );

    testWidgets(
      "applies the opened button border color from the metrics theme if open",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        await openDropdownMenu(tester);

        final decoration = findBoxDecoration(tester);
        final boxBorder = decoration.border as Border;

        expect(boxBorder.top.color, equals(openedButtonBorderColor));
        expect(boxBorder.bottom.color, equals(openedButtonBorderColor));
        expect(boxBorder.right.color, equals(openedButtonBorderColor));
        expect(boxBorder.left.color, equals(openedButtonBorderColor));
      },
    );

    testWidgets(
      "applies the hover border color from the metrics theme if hovered",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(theme: theme),
        );

        final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder);
        const pointerExitEvent = PointerEnterEvent();
        mouseRegion.onEnter(pointerExitEvent);

        await tester.pump();

        final decoration = findBoxDecoration(tester);
        final boxBorder = decoration.border as Border;

        expect(boxBorder.top.color, equals(hoverBorderColor));
        expect(boxBorder.bottom.color, equals(hoverBorderColor));
        expect(boxBorder.right.color, equals(hoverBorderColor));
        expect(boxBorder.left.color, equals(hoverBorderColor));
      },
    );

    testWidgets(
      "displays a metrics dropdown body when open",
      (tester) async {
        await tester.pumpWidget(const _MetricsDropdownMenuTestbed(
          theme: theme,
        ));

        await openDropdownMenu(tester);

        expect(find.byType(MetricsDropdownBody), findsOneWidget);
      },
    );

    testWidgets(
      "delegates the given items to the dropdown menu widget",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsDropdownMenuTestbed(items: items),
        );

        final dropdownMenu = tester.widget<DropdownMenu>(
          find.byWidgetPredicate((widget) => widget is DropdownMenu),
        );

        expect(dropdownMenu.items, equals(items));
      },
    );

    testWidgets(
      "calls the given on item selected callback on tap on the dropdown item",
      (tester) async {
        bool isCalled = false;

        await tester.pumpWidget(
          _MetricsDropdownMenuTestbed(
            items: items,
            itemBuilder: (_, item) => _DropdownTestItem(item: item),
            onItemSelected: (value) => isCalled = true,
          ),
        );

        await openDropdownMenu(tester);

        await tester.tap(find.byType(_DropdownTestItem).last);

        expect(isCalled, isTrue);
      },
    );

    testWidgets(
      "builds items using the given item builder",
      (tester) async {
        await tester.pumpWidget(
          _MetricsDropdownMenuTestbed(
            items: items,
            selectedItemBuilder: (_, item) => Text(item),
            itemBuilder: (_, item) => _DropdownTestItem(item: item),
          ),
        );

        await openDropdownMenu(tester);

        expect(find.byType(_DropdownTestItem), findsWidgets);
      },
    );

    testWidgets(
      "builds a selected item using the given selected item builder",
      (tester) async {
        await tester.pumpWidget(
          _MetricsDropdownMenuTestbed(
            items: items,
            itemBuilder: (_, item) => Text(item),
            selectedItemBuilder: (_, item) => _DropdownTestItem(item: item),
          ),
        );

        expect(find.byType(_DropdownTestItem), findsOneWidget);
      },
    );
  });
}

/// A testbed class needed to test the [MetricsDropdownMenu] widget.
class _MetricsDropdownMenuTestbed extends StatelessWidget {
  /// A dropdown items to display.
  final List<String> items;

  /// A [DropdownItemBuilder] used to build the dropdown items.
  final DropdownItemBuilder<String> itemBuilder;

  /// A [DropdownItemBuilder] used to build a selected dropdown item.
  final DropdownItemBuilder<String> selectedItemBuilder;

  /// A [ValueChanged] callback called when selecting an item from the list.
  final ValueChanged<String> onItemSelected;

  /// A [MetricsThemeData] used in tests.
  final MetricsThemeData theme;

  /// Creates a new instance of this testbed.
  ///
  /// The [selectedItemBuilder] defaults to [_defaultItemBuilder].
  /// The [itemBuilder] defaults to [_defaultItemBuilder].
  /// The [theme] defaults to the empty `MetricsThemeData`.
  const _MetricsDropdownMenuTestbed({
    Key key,
    this.items,
    this.selectedItemBuilder = _defaultItemBuilder,
    this.itemBuilder = _defaultItemBuilder,
    this.theme = const MetricsThemeData(),
    this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      metricsThemeData: theme,
      body: MetricsDropdownMenu<String>(
        items: items,
        itemBuilder: itemBuilder,
        selectedItemBuilder: selectedItemBuilder,
        onItemSelected: onItemSelected,
      ),
    );
  }

  /// A default item builder used in this testbed.
  static Widget _defaultItemBuilder(BuildContext context, String item) {
    return _DropdownTestItem(item: item);
  }
}

/// A dropdown item widget used in tests.
class _DropdownTestItem extends StatelessWidget {
  /// An [item] to display.
  final String item;

  /// Creates a new instance of this widget with the given [item].
  const _DropdownTestItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(item ?? '');
  }
}
