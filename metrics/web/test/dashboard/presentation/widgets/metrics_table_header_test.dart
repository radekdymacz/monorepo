import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/metrics_theme/config/dimensions_config.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_table/theme_data/metrics_table_header_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_table/theme_data/project_metrics_table_theme_data.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_header.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_title_header.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_loading_header.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_row.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/dimensions_util.dart';
import '../../../test_utils/metrics_themed_testbed.dart';
import '../../../test_utils/project_metrics_notifier_mock.dart';
import '../../../test_utils/test_injection_container.dart';

// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors

void main() {
  group("MetricsTableHeader", () {
    setUpAll(() {
      DimensionsUtil.setTestWindowSize(width: DimensionsConfig.contentWidth);
    });

    tearDownAll(() {
      DimensionsUtil.clearTestWindowSize();
    });

    testWidgets(
      "contains MetricsTableRow",
      (tester) async {
        await tester.pumpWidget(_DashboardTableHeaderTestbed());

        expect(find.byType(MetricsTableRow), findsOneWidget);
      },
    );

    testWidgets(
      "displays the metrics table header title if project metrics is not loading",
      (tester) async {
        final notifier = ProjectMetricsNotifierMock();
        when(notifier.isMetricsLoading).thenReturn(false);

        await tester.pumpWidget(_DashboardTableHeaderTestbed(
          metricsNotifier: notifier,
        ));

        expect(find.byType(MetricsTableTitleHeader), findsOneWidget);
      },
    );

    testWidgets(
      "displays the metrics table loading header if project metrics is loading",
      (tester) async {
        final notifier = ProjectMetricsNotifierMock();
        when(notifier.isMetricsLoading).thenReturn(true);

        await tester.pumpWidget(_DashboardTableHeaderTestbed(
          metricsNotifier: notifier,
        ));

        expect(find.byType(MetricsTableLoadingHeader), findsOneWidget);
      },
    );

    testWidgets(
      "applies the text style from the metrics theme",
      (tester) async {
        const textStyle = TextStyle(color: Colors.red);

        const themeData = MetricsThemeData(
          projectMetricsTableTheme: ProjectMetricsTableThemeData(
            metricsTableHeaderTheme:
                MetricsTableHeaderThemeData(textStyle: textStyle),
          ),
        );

        await tester.pumpWidget(
          _DashboardTableHeaderTestbed(themeData: themeData),
        );

        final defaultTextStyle = tester.widget<DefaultTextStyle>(
          find.descendant(
            of: find.byType(MetricsTableHeader),
            matching: find.byType(DefaultTextStyle),
          ),
        );

        expect(defaultTextStyle.style, equals(textStyle));
      },
    );
  });
}

/// A testbed class required to test the [MetricsTableHeader] widget.
class _DashboardTableHeaderTestbed extends StatelessWidget {
  /// A [ProjectMetricsNotifier] that will injected and used in tests.
  final ProjectMetricsNotifier metricsNotifier;

  /// A [MetricsThemeData] used in tests.
  final MetricsThemeData themeData;

  /// Creates an instance of this testbed
  /// with the given [themeData] and [metricsNotifier].
  ///
  /// The [themeData] defaults to a [MetricsThemeData].
  const _DashboardTableHeaderTestbed({
    Key key,
    this.metricsNotifier,
    this.themeData = const MetricsThemeData(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestInjectionContainer(
      metricsNotifier: metricsNotifier,
      child: MetricsThemedTestbed(
        metricsThemeData: themeData,
        body: MetricsTableHeader(),
      ),
    );
  }
}
