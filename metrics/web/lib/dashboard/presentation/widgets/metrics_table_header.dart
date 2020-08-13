import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/loading_builder.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/strings/dashboard_strings.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_header_loading_placeholder.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_row.dart';
import 'package:provider/provider.dart';

/// Widget that displays the header of the metrics table.
class MetricsTableHeader extends StatelessWidget {
  const MetricsTableHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MetricsTheme.of(context)
        .projectMetricsTableTheme
        .metricsTableHeaderTheme;

    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: theme.textStyle,
      child: Selector<ProjectMetricsNotifier, bool>(
        selector: (_, state) => state.projectMetricsIsLoading,
        builder: (_, isLoading, __) {
          return MetricsTableRow(
            status: Container(),
            name: Container(),
            buildResults: LoadingBuilder(
              isLoading: isLoading,
              builder: (_) => const Text(DashboardStrings.lastBuilds),
              loadingPlaceholder: MetricsTableHeaderLoadingPlaceholder(),
            ),
            performance: LoadingBuilder(
              isLoading: isLoading,
              builder: (_) => const Text(DashboardStrings.performance),
              loadingPlaceholder: MetricsTableHeaderLoadingPlaceholder(),
            ),
            buildNumber: LoadingBuilder(
              isLoading: isLoading,
              builder: (_) => const Text(DashboardStrings.builds),
              loadingPlaceholder: MetricsTableHeaderLoadingPlaceholder(),
            ),
            stability: LoadingBuilder(
              isLoading: isLoading,
              builder: (_) => const Text(DashboardStrings.stability),
              loadingPlaceholder: MetricsTableHeaderLoadingPlaceholder(),
            ),
            coverage: LoadingBuilder(
              isLoading: isLoading,
              builder: (_) => const Text(DashboardStrings.coverage),
              loadingPlaceholder: MetricsTableHeaderLoadingPlaceholder(),
            ),
          );
        },
      ),
    );
  }
}
