import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:metrics/base/presentation/widgets/hand_cursor.dart';
import 'package:metrics/base/presentation/widgets/shape_with_arrow.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape/bubble.dart';

/// A widget that displays a metrics user menu with specific shape.
class MetricsUserMenuCard extends StatelessWidget {
  final double width;

  const MetricsUserMenuCard({
    Key key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const arrowWidth = 5.0;
    const arrowHeight = 5.0;
    final arrowPositionPercent = (width - 8.0 - arrowWidth) / width;
    final userMenuTheme = MetricsTheme.of(context).userMenuThemeData;
    final userMenuTextStyle = userMenuTheme.primaryTextStyle;

    return ShapeWithArrow(
      width: width,
      arrowPositionPercent: arrowPositionPercent,
      bubblePosition: BubblePosition.Top,
      backgroundColor: userMenuTheme.backgroundColor,
      arrowHeight: arrowHeight,
      arrowWidth: arrowWidth,
      padding: const EdgeInsets.only(top: arrowHeight),
      borderRadius: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
              child: Consumer<ThemeNotifier>(
                builder: (context, model, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(CommonStrings.lightTheme, style: userMenuTextStyle),
                      FlutterSwitch(
                        width: 35.0,
                        height: 20.0,
                        toggleSize: 15.0,
                        padding: 2.5,
                        activeColor: userMenuTheme.activeColor,
                        value: !model.isDark,
                        onToggle: (_) => model.changeTheme(),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: HandCursor(
                child: Text(
                  CommonStrings.projectGroups,
                  style: userMenuTextStyle,
                ),
              ),
            ),
            Divider(
              color: userMenuTheme.dividerColor,
              thickness: 1.0,
              height: 0.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: HandCursor(
                child: Text(
                  CommonStrings.logOut,
                  style: userMenuTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
