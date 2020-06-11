import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/scaffold/widget/metrics_scaffold.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/presentation/widgets/metrics_table.dart';
import 'package:metrics/dashboard/presentation/widgets/project_groups_dropdown.dart';
import 'package:metrics/dashboard/presentation/widgets/project_search_input.dart';
import 'package:provider/provider.dart';

/// Allows to quickly get primary metrics of all available projects.
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  /// A [ProjectMetricsNotifier] needed to unsubscribe from project updates in [dispose].
  ProjectMetricsNotifier _projectMetricsNotifier;

  @override
  void initState() {
    super.initState();
    _projectMetricsNotifier =
        Provider.of<ProjectMetricsNotifier>(context, listen: false);

    _projectMetricsNotifier.subscribeToProjectsNameFilter();
  }

  @override
  Widget build(BuildContext context) {
    return MetricsScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 124.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: ProjectSearchInput(
                      onChanged: _projectMetricsNotifier.filterByProjectName,
                    ),
                  ),
                  const SizedBox(width: 80.0),
                  const Expanded(
                    flex: 1,
                    child: ProjectGroupsDropdown(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MetricsTable(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _projectMetricsNotifier.unsubscribeFromBuildMetrics();
    super.dispose();
  }
}
