import 'package:flutter/foundation.dart';
import 'package:metrics/dashboard/presentation/model/project_metrics_data.dart';
import 'package:metrics/dashboard/presentation/state/project_metrics_notifier.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:metrics/project_groups/domain/entities/project_group.dart';
import 'package:metrics_core/metrics_core.dart';

/// Stub implementation of the [ProjectMetricsNotifier].
///
/// Provides test implementation of the [ProjectMetricsNotifier] methods.
class ProjectMetricsNotifierStub extends ChangeNotifier
    implements ProjectMetricsNotifier {
  static final ProjectMetricsData testProjectMetrics = ProjectMetricsData(
    projectId: '1',
    projectName: 'project',
    coverage: Percent(0.1),
    stability: Percent(0.2),
    buildNumberMetric: 0,
    averageBuildDurationInMinutes: 1,
    performanceMetrics: const [],
    buildResultMetrics: const [],
  );

  /// The list of [ProjectMetricsData].
  final List<ProjectMetricsData> _projectMetrics;

  /// Creates the [ProjectMetricsNotifierStub] with the given [projectsMetrics].
  ///
  /// If [projectsMetrics] is not passed or the `null`
  /// is passed the list containing [testProjectMetrics] used.
  ProjectMetricsNotifierStub({
    List<ProjectMetricsData> projectsMetrics,
  }) : _projectMetrics = projectsMetrics;

  @override
  List<ProjectMetricsData> get projectsMetrics =>
      _projectMetrics ?? [testProjectMetrics];

  @override
  String get projectsErrorMessage => null;

  @override
  void filterByProjectName(String value) {}

  @override
  Future<void> unsubscribeFromBuildMetrics() async {
    return;
  }

  @override
  void updateProjects(List<Project> newProjects, String errorMessage) {
    return;
  }

  @override
  void subscribeToProjectsNameFilter() {}

  @override
  void changeProjectGroupFilterViewModel(
    ProjectGroupDropdownViewModel viewModel,
  ) {}

  @override
  ProjectGroupDropdownViewModel get projectGroupFilterViewModel => null;

  @override
  List<ProjectGroup> get projectGroups => null;

  @override
  List<ProjectGroupDropdownViewModel> get projectGroupsDropdownViewModels =>
      null;

  @override
  String get projectGroupsErrorMessage => null;

  @override
  void updateProjectGroups(
    List<ProjectGroup> projectGroups,
    String projectGroupsErrorMessage,
  ) {}
}
