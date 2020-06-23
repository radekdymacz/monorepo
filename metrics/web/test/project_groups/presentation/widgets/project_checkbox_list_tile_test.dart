import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:metrics/project_groups/presentation/view_models/project_checkbox_view_model.dart';
import 'package:metrics/project_groups/presentation/widgets/project_checkbox_list_tile.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/project_groups_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

void main() {
  group("ProjectCheckboxListTile", () {
    final checkboxListTileViewModels = [
      ProjectCheckboxViewModel(id: 'id', name: 'name', isChecked: false),
      ProjectCheckboxViewModel(id: 'id', name: 'name', isChecked: true),
    ];

    testWidgets(
      "throws an AssertionError if the given projectCheckboxViewModel is null",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _ProjectCheckboxListTileTestbed(
          projectCheckboxViewModel: null,
        ));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the name of the project checkbox view model in the checkbox list tile",
      (WidgetTester tester) async {
        final viewModel = checkboxListTileViewModels.first;

        await tester.pumpWidget(
          _ProjectCheckboxListTileTestbed(
            projectCheckboxViewModel: viewModel,
          ),
        );

        final checkboxListTileFinder = find.widgetWithText(
          CheckboxListTile,
          viewModel.name,
        );

        expect(checkboxListTileFinder, findsOneWidget);
      },
    );

    testWidgets(
      "applies the checkbox value corresponding to the project checkbox view model isChecked value",
      (WidgetTester tester) async {
        final checkedViewModel = checkboxListTileViewModels.first;

        await tester.pumpWidget(
          _ProjectCheckboxListTileTestbed(
            projectCheckboxViewModel: checkedViewModel,
          ),
        );

        final widget = tester.widget<CheckboxListTile>(
          find.byType(CheckboxListTile),
        );

        expect(widget.value, equals(checkedViewModel.isChecked));
      },
    );

    testWidgets(
      ".toggleProjectCheckedStatus() is called on tap on checkbox list tile",
      (WidgetTester tester) async {
        final projectGroupsNotifierMock = ProjectGroupsNotifierMock();

        final projectCheckboxViewModel = checkboxListTileViewModels.first;
        await tester.pumpWidget(
          _ProjectCheckboxListTileTestbed(
            projectGroupsNotifier: projectGroupsNotifierMock,
            projectCheckboxViewModel: projectCheckboxViewModel,
          ),
        );

        await tester.tap(find.byType(CheckboxListTile));
        await tester.pump();

        verify(
          projectGroupsNotifierMock.toggleProjectCheckedStatus(
            isChecked: !projectCheckboxViewModel.isChecked,
            projectId: projectCheckboxViewModel.id,
          ),
        ).called(equals(1));
      },
    );
  });
}

/// A testbed widget, used to test the [ProjectCheckboxListTile] widget.
class _ProjectCheckboxListTileTestbed extends StatelessWidget {
  /// The [ProjectGroupsNotifier] to inject and use to test
  /// the [ProjectCheckboxListTile] widget.
  final ProjectGroupsNotifier projectGroupsNotifier;

  /// A view model with the data to display within
  /// the [ProjectCheckboxListTile] widget.
  final ProjectCheckboxViewModel projectCheckboxViewModel;

  /// Creates the [_ProjectCheckboxListTileTestbed] with
  /// the given [projectGroupsNotifier].
  const _ProjectCheckboxListTileTestbed({
    Key key,
    this.projectGroupsNotifier,
    this.projectCheckboxViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      projectGroupsNotifier: projectGroupsNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: ProjectCheckboxListTile(
            projectCheckboxViewModel: projectCheckboxViewModel,
          ),
        ),
      ),
    );
  }
}
