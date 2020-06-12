import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/widgets/metrics_dropdown_button.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:metrics/project_groups/presentation/view_models/project_selector_view_model.dart';

import '../../../test_utils/test_injection_container.dart';

void main() {
  group("ProjectGroupsDropdown", () {
    testWidgets("test", (tester) async {
      await tester.pumpWidget(_ProjectGroupsDropdownTestbed());

      final widget =
          tester.widget<MetricsDropdownButton>(
        find.byType(MetricsDropdownButton, skipOffstage: true),
      );

      print(widget);

//      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
    });
  });
}

/// A testbed widget used to test the [ProjectGroupsDropdown] widget.
class _ProjectGroupsDropdownTestbed extends StatelessWidget {
//  final ProjectGroupsNotifier projectGroupsNotifier;

  const _ProjectGroupsDropdownTestbed({
    Key key,
//    this.projectGroupsNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TestInjectionContainer(
//      projectGroupsNotifier: projectGroupsNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: ProjectGroupsDropdown(),
        ),
      ),
    );
  }
}
