import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/dashboard/presentation/view_models/stability_view_model.dart';
import 'package:metrics/dashboard/presentation/widgets/stability_circle_percentage.dart';
import 'package:metrics/dashboard/presentation/widgets/strategy/metrics_value_theme_strategy.dart';
import 'package:metrics/dashboard/presentation/widgets/themed_circle_percentage.dart';

import '../../../test_utils/metrics_themed_testbed.dart';

void main() {
  group("StabilityCirclePercentage", () {
    testWidgets(
      "can't be created with null percent",
      (tester) async {
        await tester.pumpWidget(const _StabilityCirclePercentageTestbed(
          stability: null,
        ));

        expect(tester.takeException(), isAssertionError);
      },
    );

    testWidgets(
      "displays the ThemedCirclePercentage with MetricValueThemeStrategy",
      (tester) async {
        await tester.pumpWidget(const _StabilityCirclePercentageTestbed());

        expect(
          find.byWidgetPredicate((widget) =>
              widget is ThemedCirclePercentage &&
              widget.themeStrategy is MetricsValueThemeStrategy),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "delegates the percent value to the ThemedCirclePercentage widget",
      (tester) async {
        const stability = StabilityViewModel(value: 0.2);

        await tester.pumpWidget(const _StabilityCirclePercentageTestbed(
          stability: stability,
        ));

        final themedCirclePercentageWidget =
            tester.widget<ThemedCirclePercentage>(
          find.byType(ThemedCirclePercentage),
        );

        expect(themedCirclePercentageWidget.percent, stability);
      },
    );
  });
}

/// A testbed class required to test the [StabilityCirclePercentage] widget.
class _StabilityCirclePercentageTestbed extends StatelessWidget {
  /// The [StabilityViewModel] to display.
  final StabilityViewModel stability;

  /// Creates the testbed instance with the given [stability].
  ///
  /// The [stability] defaults to the empty [StabilityViewModel].
  const _StabilityCirclePercentageTestbed({
    Key key,
    this.stability = const StabilityViewModel(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsThemedTestbed(
      body: StabilityCirclePercentage(
        stability: stability,
      ),
    );
  }
}
