import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/common/presentation/button/theme/attention_level/metrics_button_attention_level.dart';
import 'package:metrics/common/presentation/button/theme/style/metrics_button_style.dart';
import 'package:metrics/common/presentation/button/widgets/metrics_negative_button.dart';

// https://github.com/software-platform/monorepo/issues/140
// ignore_for_file: prefer_const_constructors

void main() {
  group("MetricsNegativeButton", () {
    test(
      ".selectStyle() returns a negative style of the given attention level",
      () {
        final button = MetricsNegativeButton(label: 'Label');
        const metricsButtonAttentionLevel = MetricsButtonAttentionLevel(
          positive: MetricsButtonStyle(color: Colors.green),
          neutral: MetricsButtonStyle(color: Colors.blue),
          negative: MetricsButtonStyle(color: Colors.red),
          inactive: MetricsButtonStyle(color: Colors.grey),
        );

        final style = button.selectStyle(metricsButtonAttentionLevel);

        expect(style, equals(metricsButtonAttentionLevel.negative));
      },
    );
  });
}
