import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/widgets/metrics_user_menu_dropdown_body.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

/// A widget that used a [SelectionMenu] to display the user menu.
class MetricsUserSelectionMenu extends StatelessWidget {
  /// A widget that triggers the user menu.
  final Widget child;

  /// A max width of this user menu.
  final double maxWidth;

  /// Creates a widget that displays the user menu.
  ///
  /// The [child] must not be `null`.
  /// The [maxWidth] must not be `null`.
  const MetricsUserSelectionMenu({
    Key key,
    @required this.child,
    @required this.maxWidth,
  })  : assert(child != null),
        assert(maxWidth != null),
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
              width: maxWidth,
            );
          },
        ),
        triggerComponent: TriggerComponent(
          builder: (component) {
            return GestureDetector(
              onTap: component.triggerMenu,
              child: child,
            );
          },
        ),
        menuPositionAndSizeComponent: MenuPositionAndSizeComponent(
          builder: (component) {
            final triggerSize = component.triggerPositionAndSize.size;
            final dx = triggerSize.width - maxWidth + 3.0;
            final dy = triggerSize.height + 8.0;

            return MenuPositionAndSize(
              positionOffset: Offset(dx, dy),
              constraints: const BoxConstraints(),
            );
          },
        ),
      ),
    );
  }
}
