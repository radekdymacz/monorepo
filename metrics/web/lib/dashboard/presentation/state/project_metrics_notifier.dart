import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:metrics/common/presentation/constants/common_constants.dart';
import 'package:metrics/dashboard/domain/entities/collections/date_time_set.dart';
import 'package:metrics/dashboard/domain/entities/metrics/build_result_metric.dart';
import 'package:metrics/dashboard/domain/entities/metrics/dashboard_project_metrics.dart';
import 'package:metrics/dashboard/domain/entities/metrics/performance_metric.dart';
import 'package:metrics/dashboard/domain/usecases/parameters/project_id_param.dart';
import 'package:metrics/dashboard/domain/usecases/receive_project_metrics_updates.dart';
import 'package:metrics/dashboard/presentation/model/build_result_bar_data.dart';
import 'package:metrics/dashboard/presentation/model/project_metrics_data.dart';
import 'package:metrics/dashboard/presentation/strings/dashboard_strings.dart';
import 'package:metrics/dashboard/view_models/project_group_dropdown_view_model.dart';
import 'package:metrics/project_groups/domain/entities/project_group.dart';
import 'package:metrics_core/metrics_core.dart';
import 'package:rxdart/rxdart.dart';

/// The [ChangeNotifier] that holds the projects metrics state.
///
/// Stores the [Project]s and their [DashboardProjectMetrics].
class ProjectMetricsNotifier extends ChangeNotifier {
  /// Provides an ability to receive project metrics updates.
  final ReceiveProjectMetricsUpdates _receiveProjectMetricsUpdates;

  /// A [Map] that holds all created [StreamSubscription].
  final Map<String, StreamSubscription> _buildMetricsSubscriptions = {};

  /// A [PublishSubject] that provides the ability to filter projects by the name.
  final _projectNameFilterSubject = PublishSubject<String>();

  /// A [Map] that holds all loaded [ProjectMetricsData].
  Map<String, ProjectMetricsData> _projectMetrics;

  /// A [List] that holds all loaded [ProjectGroup].
  List<ProjectGroup> _projectGroups;

  /// Holds the error message that occurred during loading project groups data.
  String _projectGroupsErrorMessage;

  List<ProjectGroupDropdownViewModel> _projectGroupsDropdownViewModels;
  
  /// A dummy project group view model, that can be used in a filter 
  /// to show all projects if it is selected.
  final ProjectGroupDropdownViewModel _defaultProjectGroupViewModel =
      ProjectGroupDropdownViewModel(
    id: null,
    name: DashboardStrings.allProjectGroups,
  );

  /// Holds the error message that occurred during loading projects data.
  String _projectsErrorMessage;

  /// Optional filter value that represents a part (or full) project name
  /// used to limit the displayed data.
  String _projectNameFilter;

  /// Optional filter value that represents a project group view model
  /// used to limit the displayed data.
  ProjectGroupDropdownViewModel _projectGroupFilterViewModel;

  /// Creates the project metrics store.
  ///
  /// The provided use cases should not be null.
  ProjectMetricsNotifier(
    this._receiveProjectMetricsUpdates,
  ) : assert(
          _receiveProjectMetricsUpdates != null,
          'The use case should not be null',
        );

  /// Provides a list of project metrics, filtered by the project name filter.
  List<ProjectMetricsData> get projectsMetrics {
    List<ProjectMetricsData> projectMetricsData =
        _projectMetrics?.values?.toList();

    if (projectMetricsData == null) {
      return projectMetricsData;
    }

    if (_projectNameFilter != null) {
      projectMetricsData = _applyProjectNameFilter(projectMetricsData);
    }

    if (_projectGroupFilterViewModel != null) {
      projectMetricsData = _applyProjectGroupFilter(projectMetricsData);
    }

    return projectMetricsData;
  }

  /// Applies project name filter to the list of [ProjectMetricsData].
  List<ProjectMetricsData> _applyProjectNameFilter(
    List<ProjectMetricsData> projectMetricsData,
  ) {
    return projectMetricsData
        .where(
          (project) => project.projectName
              .toLowerCase()
              .contains(_projectNameFilter.toLowerCase()),
        )
        .toList();
  }

  /// Applies project group filter to the list of [ProjectMetricsData].
  List<ProjectMetricsData> _applyProjectGroupFilter(
    List<ProjectMetricsData> projectMetricsData,
  ) {
    return projectMetricsData.where(
      (project) {
        if (_projectGroupFilterViewModel.id != null) {
          return _projectGroupFilterViewModel.projectIds
              .contains(project.projectId);
        }

        return true;
      },
    ).toList();
  }

  /// Provides a list of all loaded project group.
  List<ProjectGroup> get projectGroups => _projectGroups;

  ///
  List<ProjectGroupDropdownViewModel> get projectGroupsDropdownViewModels =>
      _projectGroupsDropdownViewModels;

  /// Provides an error description that occurred during loading project groups data.
  String get projectGroupsErrorMessage => _projectGroupsErrorMessage;

  /// Provides an error description that occurred during loading metrics data.
  String get projectsErrorMessage => _projectsErrorMessage;

  /// Provides a filter value that represents a project group id used to limit the displayed data.
  ProjectGroupDropdownViewModel get projectGroupFilterViewModel =>
      _projectGroupFilterViewModel;

  /// Subscribes to a projects name filter.
  void subscribeToProjectsNameFilter() {
    _projectNameFilterSubject
        .debounceTime(const Duration(milliseconds: CommonConstants.debounce))
        .listen((value) {
      _projectNameFilter = value;
      notifyListeners();
    });
  }

  /// Adds project metrics filter using [value] provided.
  void filterByProjectName(String value) {
    _projectNameFilterSubject.add(value);
  }

  void changeCurrentViewModelFilter(ProjectGroupDropdownViewModel viewModel) {
    _projectGroupFilterViewModel = viewModel;

    notifyListeners();
  }

  /// Updates a list of project groups and project groups error message.
  void updateProjectGroups(
    List<ProjectGroup> projectGroups,
    String projectGroupsErrorMessage,
  ) {
    if (projectGroups == null) {
      return;
    }

    _projectGroupsDropdownViewModels = [_defaultProjectGroupViewModel];

    _projectGroupsDropdownViewModels.addAll(
      projectGroups.map(
        (projectGroup) => ProjectGroupDropdownViewModel(
          id: projectGroup.id,
          name: projectGroup.name,
          projectIds: projectGroup.projectIds,
        ),
      ),
    );

    _projectGroupsErrorMessage = projectsErrorMessage;

    _updateProjectGroupFilterViewModel();

    notifyListeners();
  }

  /// Updates a project group filter.
  /// 
  /// If project groups were updated, the current project group filter view model
  /// needs to be updated too, to get the last changes.
  void _updateProjectGroupFilterViewModel() {
    final newProjectGroupFilterViewModel =
        _projectGroupsDropdownViewModels.firstWhere(
      (element) => _projectGroupFilterViewModel?.id == element.id,
      orElse: () => _defaultProjectGroupViewModel,
    );

    _projectGroupFilterViewModel = newProjectGroupFilterViewModel;
  }

  void changeProjecurrentFilterViewModel(
      ProjectGroupDropdownViewModel viewModel) {
    _projectGroupFilterViewModel = viewModel;

    notifyListeners();
  }

  /// Updates projects and error message.
  void updateProjects(List<Project> newProjects, String errorMessage) {
    _projectsErrorMessage = errorMessage;

    if (newProjects == null) return;

    if (newProjects.isEmpty) {
      _projectMetrics = {};
      notifyListeners();
      return;
    }

    final projectsMetrics = _projectMetrics ?? {};

    final projectIds = newProjects.map((project) => project.id);
    projectsMetrics.removeWhere((projectId, value) {
      final remove = !projectIds.contains(projectId);
      if (remove) {
        _buildMetricsSubscriptions.remove(projectId)?.cancel();
      }

      return remove;
    });

    for (final project in newProjects) {
      final projectId = project.id;

      ProjectMetricsData projectMetrics = projectsMetrics[projectId] ??
          ProjectMetricsData(projectId: projectId);

      if (projectMetrics.projectName != project.name) {
        projectMetrics = projectMetrics.copyWith(
          projectName: project.name,
        );
      }

      if (!projectsMetrics.containsKey(projectId)) {
        _subscribeToBuildMetrics(projectId);
      }
      projectsMetrics[projectId] = projectMetrics;
    }

    _projectMetrics = projectsMetrics;
    notifyListeners();
  }

  Future<void> unsubscribeFromBuildMetrics() async {
    await _cancelSubscriptions();
    notifyListeners();
  }

  /// Subscribes to project metrics.
  void _subscribeToBuildMetrics(String projectId) {
    final dashboardMetricsStream = _receiveProjectMetricsUpdates(
      ProjectIdParam(projectId),
    );

    _buildMetricsSubscriptions[projectId] =
        dashboardMetricsStream.listen((metrics) {
      _createProjectMetrics(metrics, projectId);
    }, onError: _errorHandler);
  }

  /// Creates project metrics from [DashboardProjectMetrics].
  void _createProjectMetrics(
      DashboardProjectMetrics dashboardMetrics, String projectId) {
    final projectsMetrics = _projectMetrics ?? {};

    final projectMetrics = projectsMetrics[projectId];

    if (projectMetrics == null || dashboardMetrics == null) return;

    final performanceMetrics = _getPerformanceMetrics(
      dashboardMetrics.performanceMetrics,
    );
    final buildResultMetrics = _getBuildResultMetrics(
      dashboardMetrics.buildResultMetrics,
    );
    final averageBuildDuration =
        dashboardMetrics.performanceMetrics.averageBuildDuration.inMinutes;
    final numberOfBuilds = dashboardMetrics.buildNumberMetrics.numberOfBuilds;

    projectsMetrics[projectId] = projectMetrics.copyWith(
      performanceMetrics: performanceMetrics,
      buildResultMetrics: buildResultMetrics,
      buildNumberMetric: numberOfBuilds,
      averageBuildDurationInMinutes: averageBuildDuration,
      coverage: dashboardMetrics.coverage,
      stability: dashboardMetrics.stability,
    );

    _projectMetrics = projectsMetrics;
    notifyListeners();
  }

  /// Creates the project performance metrics from [PerformanceMetric].
  List<Point<int>> _getPerformanceMetrics(PerformanceMetric metric) {
    final performanceMetrics = metric?.buildsPerformance ?? DateTimeSet();

    if (performanceMetrics.isEmpty) {
      return [];
    }

    return performanceMetrics.map((metric) {
      return Point(
        metric.date.millisecondsSinceEpoch,
        metric.duration.inMilliseconds,
      );
    }).toList();
  }

  /// Creates the project build result metrics from [BuildResultMetric].
  List<BuildResultBarData> _getBuildResultMetrics(BuildResultMetric metrics) {
    final buildResults = metrics?.buildResults ?? [];

    if (buildResults.isEmpty) {
      return [];
    }

    return buildResults.map((result) {
      return BuildResultBarData(
        url: result.url,
        buildStatus: result.buildStatus,
        value: result.duration.inMilliseconds,
      );
    }).toList();
  }

  /// Cancels all created subscriptions.
  Future<void> _cancelSubscriptions() async {
    for (final subscription in _buildMetricsSubscriptions.values) {
      await subscription?.cancel();
    }
    _projectMetrics = null;
    _buildMetricsSubscriptions.clear();
  }

  /// Saves the error [String] representation to [_errorMessage].
  void _errorHandler(error) {
    if (error is PlatformException) {
      _projectsErrorMessage = error.message;
      notifyListeners();
    }
  }

  @override
  FutureOr<void> dispose() async {
    await _cancelSubscriptions();
    await _projectNameFilterSubject.close();
    super.dispose();
  }
}
