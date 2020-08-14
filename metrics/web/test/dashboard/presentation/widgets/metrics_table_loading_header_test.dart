import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/metrics_theme/config/dimensions_config.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_header_loading_placeholder.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_loading_header.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_row.dart';

import '../../../test_utils/dimensions_util.dart';

void main() {
  group("MetricsTableLoadingHeader", () {
    setUpAll(() {
      DimensionsUtil.setTestWindowSize(width: DimensionsConfig.contentWidth);
    });

    tearDownAll(() {
      DimensionsUtil.clearTestWindowSize();
    });

    final isAMetricsTableHeaderPlaceholder =
        isA<MetricsTableHeaderLoadingPlaceholder>();

    testWidgets(
      "applies an empty container to the build status",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(metricsTableRowWidget.status, isA<Container>());
      },
    );

    testWidgets(
      "applies an empty container to the project name",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(metricsTableRowWidget.name, isA<Container>());
      },
    );

    testWidgets(
      "applies the build results placeholder",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.buildResults,
          isAMetricsTableHeaderPlaceholder,
        );
      },
    );

    testWidgets(
      "applies the performance placeholder",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.performance,
          isAMetricsTableHeaderPlaceholder,
        );
      },
    );

    testWidgets(
      "applies the build number placeholder",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.buildNumber,
          isAMetricsTableHeaderPlaceholder,
        );
      },
    );

    testWidgets(
      "applies the stability placeholder",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.stability,
          isAMetricsTableHeaderPlaceholder,
        );
      },
    );

    testWidgets(
      "applies the coverage placeholder",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.coverage,
          isAMetricsTableHeaderPlaceholder,
        );
      },
    );
  });
}

/// A testbed class required to test the [MetricsTableLoadingHeader] widget.
class _MetricsTableLoadingHeaderTestbed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MetricsTableLoadingHeader(),
      ),
    );
  }
}
