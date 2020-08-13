import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_table/theme_data/metrics_table_loading_placeholder_theme_data.dart';
import 'package:test/test.dart';

// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors

void main() {
  group("MetricsTableLoadingPlaceholderThemeData", () {
    test("creates a theme with the given background color", () {
      const backgroundColor = Colors.red;

      final themeData = MetricsTableLoadingPlaceholderThemeData(
        backgroundColor: backgroundColor,
      );

      expect(themeData.backgroundColor, equals(backgroundColor));
    });

    test("creates a theme with the given shimmer color", () {
      const shimmerColor = Colors.black;

      final themeData = MetricsTableLoadingPlaceholderThemeData(
        shimmerColor: shimmerColor,
      );

      expect(themeData.shimmerColor, equals(shimmerColor));
    });
  });
}
