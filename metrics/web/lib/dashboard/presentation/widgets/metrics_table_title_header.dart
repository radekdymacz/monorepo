import 'package:flutter/material.dart';
import 'package:metrics/dashboard/presentation/strings/dashboard_strings.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table_row.dart';

/// A widget that displays a metrics table header with metrics titles.
class MetricsTableTitleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MetricsTableRow(
      status: Container(),
      name: Container(),
      buildResults: const Text(DashboardStrings.lastBuilds),
      performance: const Text(DashboardStrings.performance),
      buildNumber: const Text(DashboardStrings.builds),
      stability: const Text(DashboardStrings.stability),
      coverage: const Text(DashboardStrings.coverage),
    );
  }
}
