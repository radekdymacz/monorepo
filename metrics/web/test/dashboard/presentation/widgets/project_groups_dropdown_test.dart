import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/widgets/metrics_dropdown_button.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/project_metrics_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

void main() {
  group("ProjectGroupsDropdown", () {
    final projectMetricsNotifierMock = ProjectMetricsNotifierMock();
    final projectGroupDropdownViewModels = [
      ProjectGroupDropdownViewModel(
        id: 'id1',
        name: 'name1',
        projectIds: ['id1', 'id2'],
      ),
      ProjectGroupDropdownViewModel(
        id: 'id1',
        name: 'name1',
        projectIds: ['id1', 'id2'],
      ),
    ];

    setUpAll(() {
      when(projectMetricsNotifierMock.projectGroupsDropdownViewModels)
          .thenReturn(projectGroupDropdownViewModels);
    });

    tearDownAll(() {
      reset(projectMetricsNotifierMock);
    });

    testWidgets(
      "displays the project groups dropdown",
      (tester) async {
        await tester.pumpWidget(const _ProjectGroupsDropdownTestbed());

        expect(
          find.byWidgetPredicate((widget) =>
              widget is MetricsDropdownButton<ProjectGroupDropdownViewModel>),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "displays a list of view models as a dropdown menu items",
      (tester) async {
        await tester.pumpWidget(_ProjectGroupsDropdownTestbed(
          projectMetricsNotifier: projectMetricsNotifierMock,
        ));

        final expectedLength = projectGroupDropdownViewModels.length;
        final actualLength = tester
            .widgetList(
              find.byWidgetPredicate((widget) =>
                  widget is DropdownMenuItem<ProjectGroupDropdownViewModel>),
            )
            .length;

        expect(expectedLength, equals(actualLength));
      },
    );

    testWidgets(
      "triggers changeProjectGroupFilterViewModel method after tap on dropdown menu item",
      (tester) async {
        await tester.pumpWidget(_ProjectGroupsDropdownTestbed(
          projectMetricsNotifier: projectMetricsNotifierMock,
        ));

        await tester.tap(
          find
              .byWidgetPredicate((widget) =>
                  widget is MetricsDropdownButton<ProjectGroupDropdownViewModel>)
              .last,
        );

        await tester.pumpAndSettle();

        await tester.tap(
          find
              .byWidgetPredicate((widget) =>
                  widget is DropdownMenuItem<ProjectGroupDropdownViewModel>)
              .last,
        );

        await tester.pumpAndSettle();

        verify(projectMetricsNotifierMock.changeProjectGroupFilterViewModel(any))
            .called(1);
      },
    );
  });
}

/// A testbed widget used to test the [ProjectGroupsDropdown] widget.
class _ProjectGroupsDropdownTestbed extends StatelessWidget {
  final ProjectMetricsNotifier projectMetricsNotifier;

  const _ProjectGroupsDropdownTestbed({
    Key key,
    this.projectMetricsNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      metricsNotifier: projectMetricsNotifier,
      child: const MaterialApp(
        home: Scaffold(
          body: ProjectGroupsDropdown(),
        ),
      ),
    );
  }
}
