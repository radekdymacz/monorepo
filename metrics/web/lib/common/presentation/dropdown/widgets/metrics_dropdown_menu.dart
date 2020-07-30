import 'package:flutter/material.dart';
import 'package:metrics/base/presentation/widgets/dropdown_menu.dart';
import 'package:metrics/common/presentation/dropdown/widgets/metrics_dropdown_body.dart';
import 'package:metrics/common/presentation/dropdown/theme/theme_data/dropdown_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/model/metrics_theme_data.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:selection_menu/components_configurations.dart';

/// A metrics [DropdownMenu] widget.
///
/// Applies the style from the [MetricsThemeData.dropdownTheme].
/// Uses the [MetricsDropdownBody] as a body of the opened dropdown menu.
class MetricsDropdownMenu<T> extends StatefulWidget {
  /// A dropdown items to display.
  final List<T> items;

  /// A [DropdownItemBuilder] used to build a dropdown items.
  final DropdownItemBuilder<T> itemBuilder;

  /// A [DropdownItemBuilder] used to build a selected dropdown item.
  final DropdownItemBuilder<T> selectedItemBuilder;

  /// A [ValueChanged] callback called when selecting an item from the list.
  final ValueChanged<T> onItemSelected;

  /// Creates a [MetricsDropdownMenu].
  ///
  /// Both [itemBuilder] and [selectedItemBuilder] must not be null.
  const MetricsDropdownMenu({
    Key key,
    @required this.itemBuilder,
    @required this.selectedItemBuilder,
    this.items,
    this.onItemSelected,
  })  : assert(itemBuilder != null),
        assert(selectedItemBuilder != null),
        super(key: key);

  @override
  _MetricsDropdownMenuState<T> createState() => _MetricsDropdownMenuState<T>();
}

class _MetricsDropdownMenuState<T> extends State<MetricsDropdownMenu<T>> {
  /// A height of this dropdown menu when closed.
  static const double _menuButtonHeight = 48.0;

  /// Indicates whether the project groups dropdown is opened or not.
  bool _isOpened = false;

  /// Indicates whether widget is hovered or not.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = MetricsTheme.of(context).dropdownTheme;

    return DropdownMenu<T>(
      itemHeight: 40.0,
      initiallySelectedItemIndex: 0,
      maxVisibleItems: 5,
      items: widget.items,
      onItemSelected: widget.onItemSelected,
      menuPadding: const EdgeInsets.only(
        top: _menuButtonHeight,
      ),
      menuBuilder: (data) {
        if (data.menuState == MenuState.OpeningStart) {
          _isOpened = true;
        } else if (data.menuState == MenuState.ClosingStart) {
          _isOpened = false;
        }

        return MetricsDropdownBody(data: data);
      },
      itemBuilder: widget.itemBuilder,
      buttonBuilder: (_, item) {
        final backgroundColor = _getBackgroundColor(theme);
        final borderColor = _getBorderColor(theme);

        return MouseRegion(
          onEnter: (_) => _changeHover(true),
          onExit: (_) => _changeHover(false),
          child: Container(
            height: _menuButtonHeight,
            width: 212.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: widget.selectedItemBuilder(context, item),
          ),
        );
      },
    );
  }

  /// Changes [_isHovered] value to the given [value].
  void _changeHover(bool value) {
    setState(() => _isHovered = value);
  }

  /// Selects the border color from the theme corresponding to a current state.
  Color _getBorderColor(DropdownThemeData theme) {
    if (_isHovered) return theme.hoverBorderColor;

    if (_isOpened) return theme.openedButtonBorderColor;

    return theme.closedButtonBorderColor;
  }

  /// Selects the background color from the theme corresponding to a current state.
  Color _getBackgroundColor(DropdownThemeData theme) {
    if (_isHovered) return theme.hoverBackgroundColor;

    if (_isOpened) return theme.openedButtonBackgroundColor;

    return theme.closedButtonBackgroundColor;
  }
}
