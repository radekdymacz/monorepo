import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/padded_card.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_dialog_view_model.dart';
import 'package:metrics/project_groups/presentation/widgets/add_project_group_card.dart';
import 'package:metrics/project_groups/presentation/widgets/add_project_group_dialog.dart';
import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/metrics_themed_testbed.dart';
import '../../../test_utils/project_groups_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

void main() {
  group("AddProjectGroupCard", () {
    testWidgets(
      "displays the padded card",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _AddProjectGroupCardTestbed());

        expect(find.byType(PaddedCard), findsOneWidget);
      },
    );

    testWidgets(
      "shows the add project group dialog on tap",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _AddProjectGroupCardTestbed());

        expect(find.byType(AddProjectGroupDialog), findsNothing);

        await tester.tap(find.byType(AddProjectGroupCard));
        await tester.pump();

        expect(find.byType(AddProjectGroupDialog), findsOneWidget);
      },
    );

    testWidgets(
      ".setProjectGroupDialogViewModel() method from project groups notifier called no tap on card",
      (WidgetTester tester) async {
        final projectGroupsNotifier = ProjectGroupsNotifierMock();

        when(projectGroupsNotifier.projectGroupDialogViewModel).thenReturn(
          ProjectGroupDialogViewModel(
            id: 'id',
            name: 'name',
            selectedProjectIds: [],
          ),
        );

        await tester.pumpWidget(_AddProjectGroupCardTestbed(
          projectGroupsNotifier: projectGroupsNotifier,
        ));

        await tester.tap(find.byType(AddProjectGroupCard));
        await tester.pump();

        verify(projectGroupsNotifier.setProjectGroupDialogViewModel())
            .called(equals(1));
      },
    );

    testWidgets(
      "applies the background color from the metrics inactive widget theme to the PaddedCard widget",
      (WidgetTester tester) async {
        const backgroundColor = Colors.red;

        const metricsTheme = MetricsThemeData(
          inactiveWidgetTheme: MetricWidgetThemeData(
            backgroundColor: backgroundColor,
          ),
        );

        await tester.pumpWidget(
          const _AddProjectGroupCardTestbed(theme: metricsTheme),
        );

        final cardWidget = tester.widget<PaddedCard>(
          find.byType(PaddedCard),
        );

        expect(
          cardWidget.backgroundColor,
          equals(backgroundColor),
        );
      },
    );

    testWidgets(
      "displays the add icon",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _AddProjectGroupCardTestbed());

        expect(find.byIcon(Icons.add), findsOneWidget);
      },
    );

    testWidgets(
      "displays the add project group text",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _AddProjectGroupCardTestbed());

        expect(find.text(ProjectGroupsStrings.addProjectGroup), findsOneWidget);
      },
    );
  });
}

/// A testbed widget, used to test the [AddProjectGroupCard] widget.
class _AddProjectGroupCardTestbed extends StatelessWidget {
  /// A [ProjectGroupsNotifier] used in testbed.
  final ProjectGroupsNotifier projectGroupsNotifier;

  /// The [MetricsThemeData] used in testbed.
  final MetricsThemeData theme;

  /// Creates the [_AddProjectGroupCardTestbed] with the given [theme]
  /// and the [projectGroupsNotifier].
  ///
  /// The [theme] defaults to [MetricsThemeData].
  const _AddProjectGroupCardTestbed({
    Key key,
    this.projectGroupsNotifier,
    this.theme = const MetricsThemeData(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      projectGroupsNotifier: projectGroupsNotifier,
      child: MetricsThemedTestbed(
        metricsThemeData: theme,
        body: AddProjectGroupCard(),
      ),
    );
  }
}
