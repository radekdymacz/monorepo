import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/auth/presentation/state/auth_notifier.dart';
import 'package:metrics/common/presentation/injector/widget/injection_container.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/common/presentation/state/projects_notifier.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/project_groups/presentation/state/project_groups_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  group("InjectionContainer", () {
    testWidgets(
      "injects an AuthNotifier",
      (tester) async {
        await tester.pumpWidget(InjectionContainerTestbed());

        final context = InjectionContainerTestbed.childKey.currentContext;

        expect(
          () => Provider.of<AuthNotifier>(context, listen: false),
          returnsNormally,
        );
      },
    );

    testWidgets(
      "injects a ThemeNotifier",
      (tester) async {
        await tester.pumpWidget(InjectionContainerTestbed());

        final context = InjectionContainerTestbed.childKey.currentContext;

        expect(
          () => Provider.of<ThemeNotifier>(context, listen: false),
          returnsNormally,
        );
      },
    );

    testWidgets(
      "injects a ProjectsNotifier",
      (tester) async {
        await tester.pumpWidget(InjectionContainerTestbed());

        final context = InjectionContainerTestbed.childKey.currentContext;

        expect(
          () => Provider.of<ProjectsNotifier>(context, listen: false),
          returnsNormally,
        );
      },
    );

    testWidgets(
      "injects a ProjectMetricsNotifier",
      (tester) async {
        await tester.pumpWidget(InjectionContainerTestbed());

        final context = InjectionContainerTestbed.childKey.currentContext;

        expect(
          () => Provider.of<ProjectMetricsNotifier>(context, listen: false),
          returnsNormally,
        );
      },
    );

    testWidgets(
      "injects a ProjectGroupsNotifier",
      (tester) async {
        await tester.pumpWidget(InjectionContainerTestbed());

        final context = InjectionContainerTestbed.childKey.currentContext;

        expect(
          () => Provider.of<ProjectGroupsNotifier>(context, listen: false),
          returnsNormally,
        );
      },
    );
  });
}

/// A testbed class needed to test the [InjectionContainer] widget.
class InjectionContainerTestbed extends StatelessWidget {
  /// A [GlobalKey] needed to get the current context of the [InjectionContainer.child].
  static final GlobalKey childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InjectionContainer(
      child: Container(
        key: childKey,
      ),
    );
  }
}
