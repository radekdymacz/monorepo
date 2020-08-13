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

    testWidgets(
      "applies the loading placeholder to the build results parameter of the metrics table row",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.buildResults,
          isA<MetricsTableHeaderLoadingPlaceholder>(),
        );
      },
    );

    testWidgets(
      "applies the loading placeholder to the performance parameter of the metrics table row",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.performance,
          isA<MetricsTableHeaderLoadingPlaceholder>(),
        );
      },
    );

    testWidgets(
      "applies the loading placeholder to the build number parameter of the metrics table row",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.buildNumber,
          isA<MetricsTableHeaderLoadingPlaceholder>(),
        );
      },
    );

    testWidgets(
      "applies the loading placeholder to the stability parameter of the metrics table row",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.stability,
          isA<MetricsTableHeaderLoadingPlaceholder>(),
        );
      },
    );

    testWidgets(
      "applies the loading placeholder to the coverage parameter of the metrics table row",
      (tester) async {
        await tester.pumpWidget(_MetricsTableLoadingHeaderTestbed());

        final metricsTableRowWidget = tester.widget<MetricsTableRow>(
          find.byType(MetricsTableRow),
        );

        expect(
          metricsTableRowWidget.coverage,
          isA<MetricsTableHeaderLoadingPlaceholder>(),
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
