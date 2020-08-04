import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/base_popup.dart';
import 'package:metrics/common/presentation/constants/duration_constants.dart';

/// A metrics popup with the metrics animation configuration.
class MetricsPopup extends StatelessWidget {
  /// The widget to trigger from.
  final Widget triggerWidget;

  /// The widget to display.
  final Widget child;

  /// The additional constraints to impose on the [child].
  final BoxConstraints boxConstraints;

  /// Used to build the [child] offset from the [triggerWidget].
  final OffsetBuilder offsetBuilder;

  const MetricsPopup({
    Key key,
    this.boxConstraints,
    @required this.child,
    @required this.triggerWidget,
    @required this.offsetBuilder,
  })  : assert(child != null),
        assert(triggerWidget != null),
        assert(offsetBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePopup(
      triggerWidget: triggerWidget,
      boxConstraints: boxConstraints,
      offsetBuilder: offsetBuilder,
      transitionBuilder: (context, anim1, anim2, child) {
        return Align(
          alignment: Alignment.topRight,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: anim1,
              curve: Curves.linear,
            ),
            child: child,
          ),
        );
      },
      transitionDuration: DurationConstants.animation,
      child: child,
    );
  }
}
