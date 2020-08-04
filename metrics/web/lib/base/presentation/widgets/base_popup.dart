import 'package:flutter/material.dart';

/// A widget with ability to open the popup.
class BasePopup extends StatelessWidget {
  /// The widget to trigger from.
  final Widget triggerWidget;

  /// The widget to display.
  final Widget child;

  /// The additional constraints to impose on the [child].
  final BoxConstraints boxConstraints;

  /// Used to build the [child] offset from the [triggerWidget].
  final OffsetBuilder offsetBuilder;

  /// Used to build the route's transitions.
  final RouteTransitionsBuilder transitionBuilder;

  /// The duration the transition going forwards.
  final Duration transitionDuration;

  /// Creates the [BasePopup].
  ///
  /// If the [boxConstraints] is null the [BoxConstraints] with
  /// the empty constructor used.
  ///
  /// The [child], the [offsetBuilder], the [transitionBuilder],
  /// the [triggerWidget] and the [transitionDuration] must not be `null`.
  const BasePopup({
    Key key,
    BoxConstraints boxConstraints,
    @required this.child,
    @required this.offsetBuilder,
    @required this.transitionBuilder,
    @required this.triggerWidget,
    @required this.transitionDuration,
  })  : boxConstraints = boxConstraints ?? const BoxConstraints(),
        assert(child != null),
        assert(offsetBuilder != null),
        assert(transitionBuilder != null),
        assert(triggerWidget != null),
        assert(transitionDuration != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _layerLink = LayerLink();

    return GestureDetector(
      onTap: () => _openPopup(context, _layerLink),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: triggerWidget,
      ),
    );
  }

  /// Opens popup from the [triggerWidget] using the [context]
  /// and the [layerLink].
  void _openPopup(BuildContext context, LayerLink layerLink) {
    final triggerBox = context.findRenderObject() as RenderBox;
    final triggerWidgetSize = triggerBox.size;
    final offset = offsetBuilder(triggerWidgetSize);

    Navigator.push(
      context,
      _PopupRoute(
        pageBuilder: (context, anim1, anim2) => transitionBuilder(
          context,
          anim1,
          anim2,
          Stack(
            children: <Widget>[
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: CompositedTransformFollower(
                  link: layerLink,
                  offset: offset,
                  child: ConstrainedBox(
                    constraints: boxConstraints,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        transitionDuration: transitionDuration,
      ),
    );
  }
}

/// Signature for the function that builds an offset using trigger widget size.
/// Used in the [BasePopup] widget.
typedef OffsetBuilder = Offset Function(Size triggerWidgetSize);

/// A popup route that overlays a widget over the current route.
class _PopupRoute extends PopupRoute {
  /// Used build the route's primary contents.
  final RoutePageBuilder pageBuilder;

  @override
  final Color barrierColor;

  @override
  final bool barrierDismissible;

  @override
  final String barrierLabel;

  @override
  final Duration transitionDuration;

  _PopupRoute({
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.pageBuilder,
    this.transitionDuration,
  });

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return pageBuilder(context, animation, secondaryAnimation);
  }
}
