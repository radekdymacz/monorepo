import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/dropdown_body.dart';
import 'package:metrics/common/presentation/constants/duration_constants.dart';
import 'package:metrics/common/presentation/widgets/metrics_user_menu_card.dart';
import 'package:selection_menu/components_configurations.dart';

/// A widget that displays a metrics user menu dropdown body.
class MetricsUserMenuDropdownBody extends StatelessWidget {
  /// An [AnimationComponentData] that provides an information
  /// about dropdown body animation.
  final AnimationComponentData data;

  /// A width of the dropdown body child.
  final double width;

  /// Creates the [MetricsUserMenuDropdownBody] with the given [data].
  ///
  /// The [data] must not be `null`.
  const MetricsUserMenuDropdownBody({
    Key key,
    @required this.data,
    this.width,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownBody(
      state: data.menuState,
      animationCurve: Curves.linear,
      animationDuration: DurationConstants.animation,
      onOpenStateChanged: _onOpenStateChanges,
      child: MetricsUserMenuCard(
        width: width,
      ),
    );
  }

  /// Listens to opened state changes.
  void _onOpenStateChanges(bool isOpen) {
    if (isOpen) {
      data.opened();
    } else {
      data.closed();
    }
  }
}
