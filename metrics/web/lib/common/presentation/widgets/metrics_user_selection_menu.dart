import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/widgets/metrics_user_menu_dropdown_body.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

/// A widget that used a [SelectionMenu] to display the user menu pop-up.
class MetricsUserSelectionMenu extends StatelessWidget {
  /// A widget that triggers the user menu.
  final Widget child;

  static const double _width = 220.0;

  static const double _topPadding = 8.0;

  static const double _rightPadding = 3.0;

  /// Creates the [MetricsUserSelectionMenu] with the given [child].
  ///
  /// The [child] must not be `null`.
  const MetricsUserSelectionMenu({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectionMenu(
      itemsList: const [],
      onItemSelected: (_) {},
      itemBuilder: (context, _, __) {
        return null;
      },
      componentsConfiguration: DropdownComponentsConfiguration(
        animationComponent: AnimationComponent(
          builder: (data) {
            return MetricsUserMenuDropdownBody(
              data: data,
            );
          },
        ),
        triggerComponent: TriggerComponent(
          builder: (data) {
            return GestureDetector(
              onTap: data.triggerMenu,
              child: child,
            );
          },
        ),
        menuPositionAndSizeComponent: MenuPositionAndSizeComponent(
          builder: (data) {
            final triggerSize = data.triggerPositionAndSize.size;
            final dx = triggerSize.width - _width + _rightPadding;
            final dy = triggerSize.height + _topPadding;

            return MenuPositionAndSize(
              positionOffset: Offset(dx, dy),
              constraints: const BoxConstraints(maxWidth: _width),
            );
          },
        ),
      ),
    );
  }
}
