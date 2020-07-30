import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/dropdown/theme/theme_data/dropdown_theme_data.dart';
import 'package:metrics/common/presentation/dropdown/widgets/metrics_dropdown_menu.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/view_models/project_group_dropdown_item_view_model.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown_item.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown_menu.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils/metrics_themed_testbed.dart';
import '../../../test_utils/project_metrics_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

void main() {
  group("ProjectGroupsDropdownMenu", () {
    ProjectMetricsNotifier metricsNotifier;

    const firstDropdownItem = ProjectGroupDropdownItemViewModel(
      id: '1',
      name: 'name1',
    );

    const secondDropdownItem = ProjectGroupDropdownItemViewModel(
      id: '2',
      name: 'name2',
    );

    const dropdownItems = [firstDropdownItem, secondDropdownItem];

    final dropdownMenuFinder = find.byWidgetPredicate(
      (widget) => widget is MetricsDropdownMenu,
    );

    Future<void> openDropdownMenu(WidgetTester tester) async {
      await tester.tap(find.byType(ProjectGroupsDropdownMenu));
      await tester.pumpAndSettle();
    }

    setUp(() {
      metricsNotifier = ProjectMetricsNotifierMock();
      when(metricsNotifier.projectGroupDropdownItems).thenReturn(dropdownItems);
    });

    testWidgets(
      "contains the metrics dropdown menu widget",
      (tester) async {
        await mockNetworkImagesFor(() {
          return tester.pumpWidget(
            _ProjectGroupsDropdownMenuTestbed(metricsNotifier: metricsNotifier),
          );
        });

        expect(
          dropdownMenuFinder,
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "applies the text style from the metrics theme to the button text",
      (tester) async {
        const textStyle = TextStyle(fontSize: 13.0);

        const theme = MetricsThemeData(
          dropdownTheme: DropdownThemeData(
            textStyle: textStyle,
          ),
        );

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(
            _ProjectGroupsDropdownMenuTestbed(
              metricsNotifier: metricsNotifier,
              theme: theme,
            ),
          );
        });

        final textContainer = tester.widget<Text>(find.descendant(
          of: find.byType(ProjectGroupsDropdownMenu),
          matching: find.byType(Text),
        ));

        expect(textContainer.style, equals(textStyle));
      },
    );

    testWidgets(
      "does not overflow on a very long project group name",
      (tester) async {
        when(metricsNotifier.projectGroupDropdownItems).thenReturn(const [
          ProjectGroupDropdownItemViewModel(
            name:
                'Some very long name to test that project groups dropdown menu widget does not overflows with a very long text in it',
          ),
        ]);

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(
            _ProjectGroupsDropdownMenuTestbed(metricsNotifier: metricsNotifier),
          );
        });

        expect(
          tester.takeException(),
          isNull,
        );
      },
    );

    testWidgets(
      "applies the project group dropdown items to the metrics dropdown menu widget",
      (tester) async {
        await mockNetworkImagesFor(() {
          return tester.pumpWidget(
            _ProjectGroupsDropdownMenuTestbed(metricsNotifier: metricsNotifier),
          );
        });

        final dropdownMenu =
            tester.widget<MetricsDropdownMenu>(dropdownMenuFinder);

        expect(dropdownMenu.items, equals(dropdownItems));
      },
    );

    testWidgets(
      "displays a dropdown button that contains the dropdown icon",
      (tester) async {
        const expectedImage = NetworkImage("icons/dropdown.svg");

        await mockNetworkImagesFor(() {
          return tester.pumpWidget(
            _ProjectGroupsDropdownMenuTestbed(metricsNotifier: metricsNotifier),
          );
        });

        final imageFinder = find.descendant(
          of: find.byType(ProjectGroupsDropdownMenu),
          matching: find.byType(Image),
        );

        final actualImage = tester.widget<Image>(imageFinder)?.image;

        expect(actualImage, equals(expectedImage));
      },
    );

    testWidgets(
      "updates a project group items if they were updated in notifier",
      (tester) async {
        when(metricsNotifier.projectGroupDropdownItems)
            .thenReturn(dropdownItems);

        await mockNetworkImagesFor(
          () => tester.pumpWidget(_ProjectGroupsDropdownMenuTestbed(
            metricsNotifier: metricsNotifier,
          )),
        );

        metricsNotifier.notifyListeners();

        const expectedViewModels = [
          ProjectGroupDropdownItemViewModel(
            id: 'id',
            name: 'name',
          ),
          ProjectGroupDropdownItemViewModel(
            id: 'id1',
            name: 'name1',
          )
        ];

        when(metricsNotifier.projectGroupDropdownItems)
            .thenReturn(expectedViewModels);

        metricsNotifier.notifyListeners();

        await openDropdownMenu(tester);

        final dropdownItemWidgets =
            tester.widgetList<ProjectGroupsDropdownItem>(
          find.byType(ProjectGroupsDropdownItem),
        );

        final actualInitialViewModels = dropdownItemWidgets
            .map((widget) => widget.projectGroupDropdownItemViewModel)
            .where((viewModel) => viewModel.id != null)
            .toList();

        expect(
          listEquals(actualInitialViewModels, expectedViewModels),
          isTrue,
        );
      },
    );

    testWidgets(
      "sets the project group filter on tap on a project group item",
      (tester) async {
        when(metricsNotifier.projectGroupDropdownItems)
            .thenReturn(dropdownItems);

        await mockNetworkImagesFor(
          () => tester.pumpWidget(_ProjectGroupsDropdownMenuTestbed(
            metricsNotifier: metricsNotifier,
          )),
        );

        await openDropdownMenu(tester);

        final itemViewModel = metricsNotifier.projectGroupDropdownItems.first;

        await tester.tap(find.text(itemViewModel.name));
        await tester.pumpAndSettle();

        verify(metricsNotifier.selectProjectGroup(itemViewModel.id))
            .called(equals(1));
      },
    );

    testWidgets(
      "displays the name of the selected project group",
      (tester) async {
        when(metricsNotifier.selectedProjectGroup)
            .thenReturn(firstDropdownItem);

        await mockNetworkImagesFor(
          () => tester.pumpWidget(_ProjectGroupsDropdownMenuTestbed(
            metricsNotifier: metricsNotifier,
          )),
        );

        expect(find.text(firstDropdownItem.name), findsOneWidget);
      },
    );
  });
}

/// A testbed class used to test the [ProjectGroupsDropdownMenu] widget.
class _ProjectGroupsDropdownMenuTestbed extends StatelessWidget {
  /// A [ProjectMetricsNotifier] used in tests.
  final ProjectMetricsNotifier metricsNotifier;

  /// A [MetricsThemeData] used in tests.
  final MetricsThemeData theme;

  /// Creates the testbed with the given [metricsNotifier].
  const _ProjectGroupsDropdownMenuTestbed({
    Key key,
    this.metricsNotifier,
    this.theme = const MetricsThemeData(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      metricsNotifier: metricsNotifier,
      child: MetricsThemedTestbed(
        metricsThemeData: theme,
        body: ProjectGroupsDropdownMenu(),
      ),
    );
  }
}
