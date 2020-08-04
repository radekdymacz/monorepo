import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/hand_cursor.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:metrics/common/presentation/widgets/metrics_popup.dart';
import 'package:metrics/common/presentation/widgets/metrics_user_menu_card.dart';

/// A widget that displayed the user menu pop-up.
class MetricsUserMenu extends StatelessWidget {
  /// A width of the metrics user menu.
  static const double _minWidth = 220.0;

  /// A right padding from the trigger widget.
  static const double _rightPadding = 3.0;

  /// A top padding from the trigger widget.
  static const double _topPadding = 3.0;

  /// Creates the [MetricsUserMenu].
  const MetricsUserMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MetricsPopup(
      triggerWidget: Tooltip(
        message: CommonStrings.openUserMenu,
        child: HandCursor(
          child: Image.network(
            'icons/avatar.svg',
            width: 32.0,
            height: 32.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
      boxConstraints: const BoxConstraints(
        minWidth: _minWidth,
      ),
      offsetBuilder: (size) {
        return Offset(
          size.width - _minWidth - _rightPadding,
          size.height + _topPadding,
        );
      },
      child: const MetricsUserMenuCard(),
    );
  }
}
