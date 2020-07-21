import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/graphs/circle_percentage.dart';
import 'package:metrics/common/presentation/metrics_theme/model/build_results_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_circle_percentage_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/project_group_card_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/project_group_dialog_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/user_menu_theme_data.dart';
import 'package:metrics/dashboard/presentation/widgets/build_result_bar_graph.dart';

/// Stores the theme data for all metric widgets.
class MetricsThemeData {
  static const MetricWidgetThemeData _defaultWidgetThemeData =
      MetricWidgetThemeData();

  /// The theme of the [CirclePercentage]
  final MetricCirclePercentageThemeData metricCirclePercentageThemeData;

  /// The theme of the metrics widgets used to set the default colors
  /// and text styles.
  final MetricWidgetThemeData metricWidgetTheme;

  /// The theme of the inactive metric widgets used when there are no data
  /// for metric.
  final MetricWidgetThemeData inactiveWidgetTheme;

  /// The theme for the [BuildResultBarGraph] used to set the colors
  /// of the graph bars.
  final BuildResultsThemeData buildResultTheme;

  /// The theme for dialogs.
  final ProjectGroupDialogThemeData projectGroupDialogTheme;

  /// The theme for project group cards.
  final ProjectGroupCardThemeData projectGroupCardTheme;

  /// The theme for the add project group card.
  final ProjectGroupCardThemeData addProjectGroupCardTheme;

  final UserMenuThemeData userMenuThemeData;

  /// Creates the [MetricsThemeData].
  const MetricsThemeData({
    MetricCirclePercentageThemeData metricCirclePercentageThemeData,
    MetricWidgetThemeData metricWidgetTheme,
    MetricWidgetThemeData inactiveWidgetTheme,
    BuildResultsThemeData buildResultTheme,
    ProjectGroupDialogThemeData projectGroupDialogTheme,
    ProjectGroupCardThemeData projectGroupCardTheme,
    ProjectGroupCardThemeData addProjectGroupCardTheme,
    UserMenuThemeData userMenuThemeData,
  })  : metricCirclePercentageThemeData = metricCirclePercentageThemeData ??
            const MetricCirclePercentageThemeData(),
        inactiveWidgetTheme = inactiveWidgetTheme ?? _defaultWidgetThemeData,
        metricWidgetTheme = metricWidgetTheme ?? _defaultWidgetThemeData,
        buildResultTheme = buildResultTheme ??
            const BuildResultsThemeData(
              canceledColor: Colors.grey,
              successfulColor: Colors.teal,
              failedColor: Colors.redAccent,
            ),
        projectGroupDialogTheme =
            projectGroupDialogTheme ?? const ProjectGroupDialogThemeData(),
        projectGroupCardTheme =
            projectGroupCardTheme ?? const ProjectGroupCardThemeData(),
        addProjectGroupCardTheme =
            addProjectGroupCardTheme ?? const ProjectGroupCardThemeData(),
        userMenuThemeData = userMenuThemeData ?? const UserMenuThemeData();

  /// Creates the new instance of the [MetricsThemeData] based on current instance.
  ///
  /// If any of the passed parameters are null, or parameter isn't specified,
  /// the value will be copied from the current instance.
  MetricsThemeData copyWith({
    MetricCirclePercentageThemeData metricCirclePercentageThemeData,
    MetricWidgetThemeData metricWidgetTheme,
    BuildResultsThemeData buildResultTheme,
    ProjectGroupDialogThemeData projectGroupDialogTheme,
    ProjectGroupCardThemeData projectGroupCardTheme,
    ProjectGroupCardThemeData addProjectGroupCardTheme,
    MetricWidgetThemeData inactiveWidgetTheme,
    UserMenuThemeData userMenuThemeData,
  }) {
    return MetricsThemeData(
      metricCirclePercentageThemeData: metricCirclePercentageThemeData ??
          this.metricCirclePercentageThemeData,
      metricWidgetTheme: metricWidgetTheme ?? this.metricWidgetTheme,
      buildResultTheme: buildResultTheme ?? this.buildResultTheme,
      projectGroupDialogTheme:
          projectGroupDialogTheme ?? this.projectGroupDialogTheme,
      projectGroupCardTheme:
          projectGroupCardTheme ?? this.projectGroupCardTheme,
      addProjectGroupCardTheme:
          addProjectGroupCardTheme ?? this.addProjectGroupCardTheme,
      inactiveWidgetTheme: inactiveWidgetTheme ?? this.inactiveWidgetTheme,
      userMenuThemeData: userMenuThemeData ?? this.userMenuThemeData,
    );
  }
}
