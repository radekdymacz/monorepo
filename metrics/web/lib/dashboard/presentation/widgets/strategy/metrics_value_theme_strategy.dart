import 'package:metrics/common/presentation/metrics_theme/model/metric_widget_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_circle_percentage_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/strategy/value_based_theme_strategy.dart';

/// A class that represents the strategy of applying the [MetricWidgetThemeData]
/// to the [ThemedCirclePercentage] widget based on the percent value.
///
/// Gets the [MetricWidgetThemeData] following the next rules:
/// * if the percent value is 0, applies the [MetricsThemeData.inactiveWidgetTheme]
/// * if the percent value is greater than [lowPercentBound] and less than [mediumPercentBound], applies the [MetricCirclePercentageThemeData.lowPercentTheme]
/// * if the percent value is greater than or equal to [mediumPercentBound] and less than [highPercentBound], applies the [MetricCirclePercentageThemeData.mediumPercentTheme]
/// * if the percent value is greater or equal to [highPercentBound], applies the [MetricCirclePercentageThemeData.highPercentTheme].
class MetricsValueThemeStrategy
    implements ValueBasedThemeStrategy<MetricWidgetThemeData, double> {
  /// Is the lower bound of the [value]
  /// to return the [MetricCirclePercentageThemeData.highPercentTheme].
  static const double highPercentBound = 0.8;

  /// Is the lower bound of the [value]
  /// to return the [MetricCirclePercentageThemeData.mediumPercentTheme].
  static const double mediumPercentBound = 0.51;

  /// Is the lower bound of the [value]
  /// to return the [MetricCirclePercentageThemeData.lowPercentTheme].
  static const double lowPercentBound = 0.0;

  const MetricsValueThemeStrategy();

  @override
  MetricWidgetThemeData getWidgetTheme(
    MetricsThemeData metricsTheme,
    double value,
  ) {
    final circlePercentageTheme = metricsTheme.metricCirclePercentageThemeData;
    final inactiveTheme = metricsTheme.inactiveWidgetTheme;
    final percent = value;

    if (percent == null) return inactiveTheme;

    if (percent >= highPercentBound) {
      return circlePercentageTheme.highPercentTheme;
    } else if (percent >= mediumPercentBound) {
      return circlePercentageTheme.mediumPercentTheme;
    } else if (percent > lowPercentBound) {
      return circlePercentageTheme.lowPercentTheme;
    } else {
      return inactiveTheme;
    }
  }
}
