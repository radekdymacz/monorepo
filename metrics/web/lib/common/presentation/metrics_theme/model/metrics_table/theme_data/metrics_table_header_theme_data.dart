import 'package:flutter/material.dart';

/// A class that stores the theme data for the metrics table header.
class MetricsTableHeaderThemeData {
  /// A background [Color] of the metrics table header item
  /// in the loading state.
  final Color loadingBackgroundColor;

  /// A [Color] of the shimmer animation.
  final Color shimmerColor;

  /// A [TextStyle] of the metrics table header text.
  final TextStyle textStyle;

  /// Creates an instance of the [MetricsTableHeaderThemeData].
  ///
  /// If the [textStyle] is null, an instance of the `TextStyle` used.
  const MetricsTableHeaderThemeData({
    this.loadingBackgroundColor,
    this.shimmerColor,
    TextStyle textStyle,
  }) : textStyle = textStyle ?? const TextStyle();
}
