import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/padded_card.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_card_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_delete_dialog_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_group_dialog_view_model.dart';
import 'package:metrics/project_groups/presentation/widgets/project_group_card.dart';
import 'package:metrics/project_groups/presentation/widgets/project_group_delete_dialog.dart';
import 'package:metrics/project_groups/presentation/widgets/update_project_group_dialog.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/metrics_themed_testbed.dart';
import '../../../test_utils/project_groups_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

void main() {
  group("ProjectGroupCard", () {
    const projectGroupCardViewModels = [
      ProjectGroupCardViewModel(id: 'id1', name: 'name1', projectsCount: 1),
      ProjectGroupCardViewModel(id: 'id2', name: 'name2', projectsCount: 0)
    ];

    testWidgets(
      "throws an AssertionError if a project group card view model is null",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const _ProjectGroupCardTestbed(projectGroupCardViewModel: null),
        );

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "aplies the background color from the metrics inactive widget theme to the padded card background",
      (WidgetTester tester) async {
        const expectedBackgroundColor = Colors.red;

        const theme = MetricsThemeData(
          inactiveWidgetTheme: MetricWidgetThemeData(
            backgroundColor: expectedBackgroundColor,
          ),
        );

        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            theme: theme,
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        final paddedCard = tester.widget<PaddedCard>(find.byType(PaddedCard));

        expect(paddedCard.backgroundColor, equals(expectedBackgroundColor));
      },
    );

    testWidgets(
      "displays a name of the project group card view model",
      (WidgetTester tester) async {
        final projectGroupCardViewModel = projectGroupCardViewModels.first;

        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModel,
          ),
        );

        expect(find.text(projectGroupCardViewModel.name), findsOneWidget);
      },
    );

    testWidgets(
      "displays a projects count of the project group card view model",
      (WidgetTester tester) async {
        final projectGroupCardViewModel = projectGroupCardViewModels.first;

        final projectsCountText = ProjectGroupsStrings.getProjectsCount(
          projectGroupCardViewModel.projectsCount,
        );

        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModel,
          ),
        );

        expect(find.text(projectsCountText), findsOneWidget);
      },
    );

    testWidgets(
      "displays the no projects text if a projects count of the project group card view model is 0",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModels.last,
          ),
        );

        expect(find.text(ProjectGroupsStrings.noProjects), findsOneWidget);
      },
    );

    testWidgets(
      "displays an edit button with the edit text",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        final editButtonFinder = find.descendant(
          of: find.byType(RawMaterialButton),
          matching: find.text(CommonStrings.edit),
        );

        expect(editButtonFinder, findsOneWidget);
      },
    );

    testWidgets(
      "displays a delete button with the delete text",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        final deleteButtonFinder = find.descendant(
          of: find.byType(RawMaterialButton),
          matching: find.text(CommonStrings.delete),
        );

        expect(deleteButtonFinder, findsOneWidget);
      },
    );

    testWidgets(
      "shows the update project group dialog on tap on the edit button",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        expect(find.byType(UpdateProjectGroupDialog), findsNothing);

        await tester.tap(
          find.descendant(
            of: find.byType(RawMaterialButton),
            matching: find.text(CommonStrings.edit),
          ),
        );

        await tester.pump();

        expect(find.byType(UpdateProjectGroupDialog), findsOneWidget);
      },
    );

    testWidgets(
      ".setProjectGroupDialogViewModel() method of the project groups notifier is called on tap on the edit button",
      (WidgetTester tester) async {
        final projectGroupsNotifier = ProjectGroupsNotifierMock();

        when(projectGroupsNotifier.projectGroupDialogViewModel).thenReturn(
          ProjectGroupDialogViewModel(
            id: 'id1',
            name: 'name',
            selectedProjectIds: [],
          ),
        );

        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupsNotifier: projectGroupsNotifier,
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        await tester.tap(
          find.descendant(
            of: find.byType(RawMaterialButton),
            matching: find.text(CommonStrings.edit),
          ),
        );

        verify(projectGroupsNotifier.setProjectGroupDialogViewModel(any))
            .called(equals(1));
      },
    );

    testWidgets(
      "shows the delete project group dialog on tap on the delete button",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        expect(find.byType(ProjectGroupDeleteDialog), findsNothing);

        await tester.tap(
          find.descendant(
            of: find.byType(RawMaterialButton),
            matching: find.text(CommonStrings.delete),
          ),
        );

        await tester.pump();

        expect(find.byType(ProjectGroupDeleteDialog), findsOneWidget);
      },
    );

    testWidgets(
      ".setProjectGroupDeleteDialogViewModel() method of the project groups notifier is called on tap on the delete button",
      (WidgetTester tester) async {
        final projectGroupsNotifier = ProjectGroupsNotifierMock();

        when(
          projectGroupsNotifier.projectGroupDeleteDialogViewModel,
        ).thenReturn(
          ProjectGroupDeleteDialogViewModel(id: 'id1', name: 'name'),
        );

        await tester.pumpWidget(
          _ProjectGroupCardTestbed(
            projectGroupsNotifier: projectGroupsNotifier,
            projectGroupCardViewModel: projectGroupCardViewModels.first,
          ),
        );

        await tester.tap(
          find.descendant(
            of: find.byType(RawMaterialButton),
            matching: find.text(CommonStrings.delete),
          ),
        );

        verify(projectGroupsNotifier.setProjectGroupDeleteDialogViewModel(any))
            .called(equals(1));
      },
    );
  });
}

/// A testbed widget, used to test the [ProjectGroupCard] widget.
class _ProjectGroupCardTestbed extends StatelessWidget {
  /// A project group card viewModel with project group data to display.
  final ProjectGroupCardViewModel projectGroupCardViewModel;

  /// A [ProjectGroupsNotifier] used in testbed.
  final ProjectGroupsNotifier projectGroupsNotifier;

  /// The [MetricsThemeData] used in testbed.
  final MetricsThemeData theme;

  /// Creates the [_ProjectGroupCardTestbed] with the given [theme]
  /// and the [projectGroupCardViewModel].
  const _ProjectGroupCardTestbed({
    Key key,
    this.theme = const MetricsThemeData(),
    this.projectGroupsNotifier,
    this.projectGroupCardViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      projectGroupsNotifier: projectGroupsNotifier,
      child: MetricsThemedTestbed(
        metricsThemeData: theme,
        body: ProjectGroupCard(
          projectGroupCardViewModel: projectGroupCardViewModel,
        ),
      ),
    );
  }
}
