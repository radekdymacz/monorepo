import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:metrics/auth/presentation/state/auth_notifier.dart';
import 'package:metrics/base/presentation/widgets/hand_cursor.dart';
import 'package:metrics/common/presentation/decoration/arrow_shape_border.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:metrics/common/presentation/routes/route_name.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:provider/provider.dart';

/// A widget that displays a metrics user menu with specific shape.
class MetricsUserMenuCard extends StatelessWidget {
  /// Creates the [MetricsUserMenuCard].
  const MetricsUserMenuCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const arrowWidth = 5.0;
    const arrowHeight = 5.0;
    const itemPadding = EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);
    final userMenuTheme = MetricsTheme.of(context).userMenuTheme;
    final userMenuTextStyle = userMenuTheme.primaryTextStyle;

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: userMenuTheme.backgroundColor,
      shape: const ArrowShapeBorder(
        borderRadius: 1.0,
        arrowWidth: arrowWidth,
        arrowHeight: arrowHeight,
        alignment: ArrowAlignment.end,
        position: ArrowPosition.top,
        offset: -8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: arrowHeight).add(
          const EdgeInsets.symmetric(vertical: 12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: itemPadding,
              child: Consumer<ThemeNotifier>(
                builder: (context, model, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CommonStrings.lightTheme,
                        style: userMenuTextStyle,
                      ),
                      HandCursor(
                        child: FlutterSwitch(
                          width: 35.0,
                          height: 20.0,
                          toggleSize: 15.0,
                          padding: 2.5,
                          activeColor: userMenuTheme.activeColor,
                          value: !model.isDark,
                          onToggle: (_) => model.changeTheme(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: itemPadding,
              child: HandCursor(
                child: GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                    context,
                    RouteName.projectGroup,
                  ),
                  child: Text(
                    CommonStrings.projectGroups,
                    style: userMenuTextStyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: itemPadding,
              child: HandCursor(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    CommonStrings.users,
                    style: userMenuTextStyle,
                  ),
                ),
              ),
            ),
            Divider(
              color: userMenuTheme.dividerColor,
              thickness: 1.0,
              height: 25.0,
            ),
            Padding(
              padding: itemPadding,
              child: HandCursor(
                child: GestureDetector(
                  onTap: () => _signOut(context),
                  child: Text(
                    CommonStrings.logOut,
                    style: userMenuTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Signs out a user from the app.
  Future<void> _signOut(BuildContext context) async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    await authNotifier.signOut();
    await Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.login,
      (Route<dynamic> route) => false,
    );
  }
}
