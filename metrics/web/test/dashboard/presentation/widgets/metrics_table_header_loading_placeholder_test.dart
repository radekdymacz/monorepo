import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/base/presentation/widgets/shimmer_container.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_table/theme_data/metrics_table_header_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_table/theme_data/project_metrics_table_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_header_loading_placeholder.dart';

import '../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("MetricsTableHeaderLoadingPlaceholder", () {
    const loadingBackgroundColor = Colors.black;
    const shimmerColor = Colors.red;

    const themeData = MetricsThemeData(
      projectMetricsTableTheme: ProjectMetricsTableThemeData(
        metricsTableHeaderTheme: MetricsTableHeaderThemeData(
          loadingBackgroundColor: loadingBackgroundColor,
          shimmerColor: shimmerColor,
        ),
      ),
    );

    testWidgets(
      "applies the shimmer color from the metrics theme to the shimmer container widget",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsTableHeaderLoadingPlaceholderTestbed(themeData: themeData),
        );

        final shimmerContainer = tester.widget<ShimmerContainer>(
          find.byType(ShimmerContainer),
        );

        expect(shimmerContainer.shimmerColor, equals(shimmerColor));
      },
    );

    testWidgets(
      "applies the loading background color from the metrics theme to the shimmer container widget",
      (tester) async {
        await tester.pumpWidget(
          const _MetricsTableHeaderLoadingPlaceholderTestbed(themeData: themeData),
        );

        final shimmerContainer = tester.widget<ShimmerContainer>(
          find.byType(ShimmerContainer),
        );

        expect(shimmerContainer.color, equals(loadingBackgroundColor));
      },
    );
  });
}

/// A testbed class required to test the [MetricsTableHeaderLoadingPlaceholder] widget.
class _MetricsTableHeaderLoadingPlaceholderTestbed extends StatelessWidget {
  /// A [MetricsThemeData] used in tests.
  final MetricsThemeData themeData;

  /// Creates an instance of this testbed with the given [themeData].
  ///
  /// The [themeData] defaults to a [MetricsThemeData].
  const _MetricsTableHeaderLoadingPlaceholderTestbed({
    Key key,
    this.themeData = const MetricsThemeData(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      metricsThemeData: themeData,
      body: MetricsTableHeaderLoadingPlaceholder(),
    );
  }
}
