import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/shimmer_container.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';

/// A widget that displays a placeholder with a shimmer effect.
class MetricsTableLoadingPlaceholder extends StatelessWidget {
  /// A height of the metrics table item.
  static const _itemHeight = 144.0;

  @override
  Widget build(BuildContext context) {
    final theme = MetricsTheme.of(context).metricsTableLoadingPlaceholderTheme;

    return LayoutBuilder(
      builder: (_, constraints) {
        return ListView.builder(
          itemCount: _calculateItemCount(constraints.maxHeight, _itemHeight),
          itemBuilder: (_, __) => ShimmerContainer(
            height: _itemHeight,
            padding: const EdgeInsets.only(bottom: 4.0),
            shimmerColor: theme.shimmerColor,
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(2.0),
          ),
        );
      },
    );
  }

  /// Calculates an item count for the [ListView]
  /// based on the [maxHeight] and [itemHeight].
  int _calculateItemCount(double maxHeight, double itemHeight) {
    final itemCount = maxHeight / itemHeight;

    return itemCount.ceil();
  }
}
