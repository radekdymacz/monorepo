import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_title_header.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_loading_header.dart';
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
        selector: (_, state) => state.isMetricsLoading,
        builder: (_, isLoading, __) {
          if (isLoading) return MetricsTableLoadingHeader();

          return MetricsTableTitleHeader();
        },
      ),
    );
  }
}
